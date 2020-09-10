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
        
        Application.shared.presentInitialScreen(in: window!)
        
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

