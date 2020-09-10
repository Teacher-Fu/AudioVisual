//
//  Kingfisher+Rx.swift
//  AudioVisual
//
//  Created by winpower on 2020/8/18.
//  Copyright © 2020 yasuo. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Kingfisher

extension Reactive where Base: UIImageView {
    
}

extension ImageCache: ReactiveCompatible {}

extension Reactive where Base: ImageCache {

    func retrieveCacheSize() -> Observable<Int> {
        return Single.create { single in
            self.base.calculateDiskStorageSize { (result) in
                do {
                    single(.success(Int(try result.get())))
                } catch {
                    single(.error(error))
                }
            }
            return Disposables.create { }
        }.asObservable()
    }

    public func clearCache() -> Observable<Void> {
        return Single.create { single in
            self.base.clearMemoryCache()
            self.base.clearDiskCache(completion: {
                single(.success(()))
            })
            return Disposables.create { }
        }.asObservable()
    }
}
