//
//  SceneDelegate.swift
//  AudioVisual
//
//  Created by winpower on 2020/7/28.
//  Copyright © 2020 yasuo. All rights reserved.
//

import UIKit
import Toast_Swift

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    static var shared: AppDelegate? {
        return UIApplication.shared.delegate as? AppDelegate
    }

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        if let windowScene = scene as? UIWindowScene {
            window = UIWindow(windowScene: windowScene)
            window?.backgroundColor = UIColor.white
        }
        
        
        let libsManager = LibsManager.shared
        libsManager.setupLibs(with: window)
        
        if Configs.Network.useStaging == true {
            // Logout 退出
            User.removeCurrentUser()
            AuthManager.removeToken() 
            
            // Use Green Dark theme 主题
            var theme = ThemeType.currentTheme()
            if theme.isDark != true {
                theme = theme.toggled()
            }
            theme = theme.withColor(color: .green) 
            themeService.switch(theme) 
            
            // Disable banners
            libsManager.bannersEnabled.accept(false)
        }
        
        if let wind = window {
            Application.shared.presentInitialScreen(in: wind)
        }
        
        window?.makeKeyAndVisible()
        
    }

    func sceneDidDisconnect(_ scene: UIScene) {

    }

    func sceneDidBecomeActive(_ scene: UIScene) {

    }

    func sceneWillResignActive(_ scene: UIScene) {

    }

    func sceneWillEnterForeground(_ scene: UIScene) {

    }

    func sceneDidEnterBackground(_ scene: UIScene) {

    }


}

