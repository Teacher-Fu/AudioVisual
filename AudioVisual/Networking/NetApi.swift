//
//  NetApi.swift
//  AudioVisual
//
//  Created by winpower on 2020/7/29.
//  Copyright © 2020 yasuo. All rights reserved.
//

import Foundation
import RxSwift
//import RxCocoa

protocol NetApi {
    func downloadFile(url: URL, fileName: String?) -> Single<String>
}
