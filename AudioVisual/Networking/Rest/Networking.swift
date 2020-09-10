//
//  Networking.swift
//  AudioVisual
//
//  Created by winpower on 2020/8/3.
//  Copyright © 2020 yasuo. All rights reserved.
//

import Foundation
import Moya
import RxSwift
import Alamofire

class OnlineProvider<Target> where Target: Moya.TargetType {
    fileprivate let online: Observable<Bool>
    fileprivate let provider: MoyaProvider<Target>
    
    init(endpointClosure: @escaping MoyaProvider<Target>.EndpointClosure = MoyaProvider<Target>.defaultEndpointMapping,
         requestClosure: @escaping MoyaProvider<Target>.RequestClosure = MoyaProvider<Target>.defaultRequestMapping,
         stubClosure: @escaping MoyaProvider<Target>.StubClosure = MoyaProvider<Target>.neverStub,
         session: Session = MoyaProvider<Target>.defaultAlamofireSession(),
         plugins: [PluginType] = [],
         trackInflights: Bool = false,
         online: Observable<Bool> = connectedToInternet()) {
        self.online = online
        self.provider = MoyaProvider(endpointClosure: endpointClosure, requestClosure: requestClosure, stubClosure: stubClosure, session: session, plugins: plugins, trackInflights: trackInflights)
    }
    
    func request(_ token: Target) -> Observable<Moya.Response> {
        let actualRequest = provider.rx.request(token)
        return online
            .ignore(value: false)  // Wait until we're online 
            .take(1)        // Take 1 to make sure we only invoke the API once.
            .flatMap { _ in // Turn the online state into a network request
                return actualRequest
                    .filterSuccessfulStatusCodes()
                    .do(onSuccess: { (response) in
                    }, onError: { (error) in
                        if let error = error as? MoyaError {
                            switch error {
                            case .statusCode(let response):
                                if response.statusCode == 401 {
                                    // Unauthorized
                                    if AuthManager.shared.hasValidToken {
                                        AuthManager.removeToken()
                                        Application.shared.presentInitialScreen(in: Application.shared.window)
                                    }
                                }
                            default: break
                            }
                        }
                    })
        }
    }
    
}

protocol NetworkingType {
    associatedtype T: TargetType
    var provider: OnlineProvider<T> { get }
}

extension NetworkingType {
    static func endpointsClosure<T>(_ xAccessToken: String? = nil) -> (T) -> Endpoint where T: TargetType {
        return { target in
            let endpoint = MoyaProvider.defaultEndpointMapping(for: target)

            // Sign all non-XApp, non-XAuth token requests
            return endpoint
        }
    }

    static func APIKeysBasedStubBehaviour<T>(_: T) -> Moya.StubBehavior {
        return .never
    }

    static var plugins: [PluginType] {
        var plugins: [PluginType] = []
        if Configs.Network.loggingEnabled == true {
            plugins.append(NetworkLoggerPlugin())
        }
        return plugins
    }

    // (Endpoint<Target>, NSURLRequest -> Void) -> Void
    static func endpointResolver() -> MoyaProvider<T>.RequestClosure {
        return { (endpoint, closure) in
            do {
                var request = try endpoint.urlRequest() // endpoint.urlRequest
                request.httpShouldHandleCookies = false
                closure(.success(request))
            } catch {
                logError(error.localizedDescription)
            }
        }
    }
}

private func newProvider<T>(_ plugins: [PluginType], xAccessToken: String? = nil) -> OnlineProvider<T> {
    return OnlineProvider(endpointClosure: AudioVisualNetworking.endpointsClosure(xAccessToken),
                          requestClosure: AudioVisualNetworking.endpointResolver(),
                          stubClosure: AudioVisualNetworking.APIKeysBasedStubBehaviour,
                          plugins: plugins)
}

struct AudioVisualNetworking: NetworkingType {
    typealias T = AudioVisualAPI
    let provider: OnlineProvider<AudioVisualAPI>
}

// MARK: - "Public" interfaces
extension AudioVisualNetworking {
    func request(_ token: AudioVisualAPI) -> Observable<Moya.Response> {
        let actualRequest = self.provider.request(token)
        return actualRequest
    }
}

// Static methods
extension NetworkingType {
    static func audioVisualNetworking() -> AudioVisualNetworking {
        return AudioVisualNetworking(provider: newProvider(plugins))
    }

}



// MARK: - Provider support
//func stubbedResponse(_ filename: String) -> Data! {
//    @objc class TestClass: NSObject { }
//
//    let bundle = Bundle(for: TestClass.self)
//    let path = bundle.path(forResource: filename, ofType: "json")
//    return (try? Data(contentsOf: URL(fileURLWithPath: path!)))
//}
//
//private extension String {
//    var URLEscapedString: String {
//        return self.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlHostAllowed)!
//    }
//}
//
//func url(_ route: TargetType) -> String {
//    return route.baseURL.appendingPathComponent(route.path).absoluteString
//}
