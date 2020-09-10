//
//  ViewModel.swift
//  AudioVisual
//
//  Created by winpower on 2020/7/30.
//  Copyright © 2020 yasuo. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import ObjectMapper

class ViewModel: NSObject {
    
    let provider: NetApi
    
    var page = 1
    
    let loading = ActivityIndicator()
    let headerLoading = ActivityIndicator()
    let footerLoading = ActivityIndicator()
    
    let error = ErrorTracker()
    let serverError = PublishSubject<Error>()
    let parsedError = PublishSubject<ApiError>()
    
    init(provider: NetApi) {
        self.provider = provider
        super.init()

        serverError.asObservable().map { (error) -> ApiError? in
            do {
                let errorResponse = error as? MoyaError
                if let body = try errorResponse?.response?.mapJSON() as? [String: Any],
                    let errorResponse = Mapper<ErrorResponse>().map(JSON: body) {
                    return ApiError.serverError(response: errorResponse)
                }
            } catch {
                print(error)
            }
            return nil
        }.filterNil().bind(to: parsedError).disposed(by: rx.disposeBag)


        parsedError.subscribe(onNext: { (error) in
            logError("\(error)")
        }).disposed(by: rx.disposeBag)
    }

    deinit {
        logDebug("\(type(of: self)): Deinited")
        logResourcesCount() 
    }
    
}
