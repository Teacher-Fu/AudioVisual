//
//  ViewModelType.swift
//  AudioVisual
//
//  Created by winpower on 2020/8/19.
//  Copyright © 2020 yasuo. All rights reserved.
//

import Foundation

protocol ViewModelType {
    associatedtype Input
    associatedtype Output

    func transform(input: Input) -> Output
}
