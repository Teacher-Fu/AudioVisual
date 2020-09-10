//
//  RestApi.swift
//  AudioVisual
//
//  Created by winpower on 2020/7/30.
//  Copyright © 2020 yasuo. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import ObjectMapper
import Moya
import Moya_ObjectMapper
import Alamofire

typealias MoyaError = Moya.MoyaError

enum ApiError: Error {
    case serverError(response: ErrorResponse)

    var title: String {
        switch self {
        case .serverError(let response): return response.message ?? ""
        }
    }
}


class RestApi: NetApi {

    private let audioVisualProvider: AudioVisualNetworking
    
    init(audioVisualProvider:AudioVisualNetworking){
        self.audioVisualProvider = audioVisualProvider
    }
    
    
}



extension RestApi {
    
    func downloadFile(url: URL, fileName: String?) -> Single<String> {
        return Single.create { single in
            DispatchQueue.global().async {
                do {
                    
                    single(.success(try String.init(contentsOf: url)))
                } catch {
                    single(.error(error))
                }
            }
            return Disposables.create { }
            }
            .observeOn(MainScheduler.instance)
    }
    
}



extension RestApi {
    private func request(_ target: AudioVisualAPI) -> Single<Any> {
        return audioVisualProvider.request(target)
            .mapJSON()
            .observeOn(MainScheduler.instance)
            .asSingle()
    }
    
    private func requestWithoutMapping(_ target: AudioVisualAPI) -> Single<Moya.Response> {
        return audioVisualProvider.request(target)
            .observeOn(MainScheduler.instance)
            .asSingle()
    }
    
    private func requestObject<T: BaseMappable>(_ target: AudioVisualAPI, type: T.Type) -> Single<T> {
        return audioVisualProvider.request(target).mapObject(T.self).observeOn(MainScheduler.instance).asSingle()
    }
    
    private func requestArray<T: BaseMappable>(_ target: AudioVisualAPI, type: T.Type) -> Single<[T]> {
        return audioVisualProvider.request(target).mapArray(T.self).observeOn(MainScheduler.instance).asSingle()
    }
}
