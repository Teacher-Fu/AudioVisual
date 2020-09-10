//
//  AudioVisualAPI.swift
//  AudioVisual
//
//  Created by winpower on 2020/8/3.
//  Copyright © 2020 yasuo. All rights reserved.
//

import Foundation
import RxSwift
import Moya
import Alamofire

private let assetDir: URL = {
    let directoryURLs = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    return directoryURLs.first ?? URL(fileURLWithPath: NSTemporaryDirectory())
}()


enum AudioVisualAPI {
    case download(url: URL, fileName: String?)
}

extension AudioVisualAPI: TargetType{
    var baseURL: URL {
        switch self {
        case .download(let url, _):
            return url
        default:
            return Configs.Network.githubBaseUrl.url!
        }
    }
    
    var path: String {
        switch self {
        case .download: return ""
        default: return ""
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .download: return .post
        default:
            return .get
        }
    }
    
    ///这个属性值可以用来后续的测试或者为开发者提供离线数据支持。
    var sampleData: Data {
        var dataUrl: URL?
        if let url = dataUrl, let data = try? Data(contentsOf: url) {
            return data
        }
        return Data()
    }
    
    var localLocation: URL {
        switch self {
        case .download(_, let fileName):
            if let fileName = fileName {
                return assetDir.appendingPathComponent(fileName)
            }
        }
        return assetDir
    }
    
    var parameters: [String: Any]? {
        var params: [String: Any] = [:]
        switch self {
        
        default: break
        }
        return params
    }
    
    public var parameterEncoding: ParameterEncoding {
        return URLEncoding.default
    }
    
    var downloadDestination: DownloadDestination {
        return { _, _ in return (self.localLocation, .removePreviousFile) }
    }
    
    var task: Task {
        switch self {
        case .download:
            return .downloadDestination(downloadDestination)
        default:
            if let parameters = parameters {
                return .requestParameters(parameters: parameters, encoding: parameterEncoding)
            }
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        if let token = AuthManager.shared.token {
            switch token.type() {
            case .basic(let token):
                return ["Authorization": "Basic \(token)"]
            case .personal(let token):
                return ["Authorization": "token \(token)"]
            case .oAuth(let token):
                return ["Authorization": "token \(token)"]
            case .unauthorized: break
            }
        }
        return nil
    }
    
    
    
}
