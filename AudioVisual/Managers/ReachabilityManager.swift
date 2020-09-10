//
//  ReachabilityManager.swift
//  AudioVisual
//
//  Created by winpower on 2020/7/30.
//  Copyright © 2020 yasuo. All rights reserved.
//

import UIKit
import RxSwift
import Alamofire


func connectedToInternet() -> Observable<Bool> {
    return ReachabilityManager.shared.reach
}

private class ReachabilityManager: NSObject {

    static let shared = ReachabilityManager()

    let reachSubject = ReplaySubject<Bool>.create(bufferSize: 1)
    var reach: Observable<Bool> {
        return reachSubject.asObservable()
    }

    override init() {
        super.init()

        NetworkReachabilityManager.default?.startListening(onUpdatePerforming: { (status) in
            switch status {
            case .notReachable:
                self.reachSubject.onNext(false)
            case .reachable:
                self.reachSubject.onNext(true)
            case .unknown:
                self.reachSubject.onNext(false)
            }
        })
    }
}
