//
//  Application.swift
//  AudioVisual
//
//  Created by winpower on 2020/7/29.
//  Copyright © 2020 yasuo. All rights reserved.
//

import UIKit

final class Application: NSObject {
    static let shared = Application()
    var window: UIWindow?
    
    var provider:NetApi?
    let authManager: AuthManager
    let navigator: Navigator
    
    private override init() {
        authManager = AuthManager.shared
        navigator = Navigator.default
        super.init()
        updateProvider()
    }
    
    private func updateProvider() {
        let  audioProvider = AudioVisualNetworking.audioVisualNetworking()
        let restApi = RestApi(audioVisualProvider: audioProvider)
        provider = restApi
    }
    
    func presentInitialScreen(in window: UIWindow?) {
        updateProvider()
        guard let window = window, let provider = provider else { return } 
        self.window = window
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {

            let viewModel = HomeTabBarViewModel(provider: provider)
            self.navigator.show(segue: .tabs(viewModel: viewModel), sender: nil, transition: .root(in: window)) 
        }
    }
    
    func presentTestScreen(in window: UIWindow?) {
        guard let window = window, let provider = provider else { return }
        let viewModel = UserViewModel(user: User(), provider: provider)
        navigator.show(segue: .userDetails(viewModel: viewModel), sender: nil, transition: .root(in: window)) 
    }

}
