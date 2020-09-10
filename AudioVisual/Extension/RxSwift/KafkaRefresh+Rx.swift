//
//  KafkaRefresh+Rx.swift
//  AudioVisual
//
//  Created by winpower on 2020/8/27.
//  Copyright © 2020 yasuo. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift
import KafkaRefresh

extension Reactive where Base: KafkaRefreshControl {

    public var isAnimating: Binder<Bool> {
        return Binder(self.base) { refreshControl, active in
            if active {
//                refreshControl.beginRefreshing()
            } else {
                refreshControl.endRefreshing()
            }
        }
    }
}
