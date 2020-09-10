//
//  ErrorResponse.swift
//  AudioVisual
//
//  Created by winpower on 2020/8/3.
//  Copyright © 2020 yasuo. All rights reserved.
//

import Foundation
import ObjectMapper

struct ErrorResponse: Mappable {
    init?(map: Map) {}
    init() {}
    
    mutating func mapping(map: Map) {}
    
    var message: String?
    var errors: [ErrorModel] = []
    var documentationUrl: String?
}

struct ErrorModel: Mappable {
    init?(map: Map) {}
    init() {}
    
    mutating func mapping(map: Map) {}
    
    var code: String?
    var message: String?
    var field: String?
    var resource: String?
    
}
