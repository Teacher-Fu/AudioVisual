//
//  LibsManager.swift
//  AudioVisual
//
//  Created by winpower on 2020/7/29.
//  Copyright © 2020 yasuo. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import SnapKit
import IQKeyboardManagerSwift
import CocoaLumberjack
import Kingfisher
import FLEX
import FirebaseCrashlytics
import NVActivityIndicatorView
import NSObject_Rx
import RxViewController
import RxOptional
import RxGesture
import SwifterSwift
import SwiftDate
import Hero
import KafkaRefresh
import Mixpanel
import FirebaseCore
import DropDown
import Toast_Swift
import GoogleMobileAds

typealias DropDownView = DropDown

class LibsManager: NSObject {
    
    /// 单利对象
    static let shared = LibsManager()
    
    let bannersEnabled = BehaviorRelay(value: UserDefaults.standard.bool(forKey: Configs.UserDefaultsKeys.bannersEnabled))
    
    override init() {
        super.init()
        
        if UserDefaults.standard.object(forKey: Configs.UserDefaultsKeys.bannersEnabled) == nil {
            bannersEnabled.accept(true)
        }
        
        
        bannersEnabled.subscribe(onNext: { (enabled) in
            UserDefaults.standard.set(enabled, forKey: Configs.UserDefaultsKeys.bannersEnabled)
//            analytics.updateUser(ads: enabled)
        }).disposed(by: rx.disposeBag)
    }
    

    
}

extension LibsManager {

    func showFlex() {
        FLEXManager.shared.showExplorer()
//        analytics.log(.flexOpened)
    }

    func removeKingfisherCache() -> Observable<Void> {
        return ImageCache.default.rx.clearCache()
    }

    func kingfisherCacheSize() -> Observable<Int> {
        return ImageCache.default.rx.retrieveCacheSize()
    }
}

extension LibsManager{
    
    func setupLibs(with window: UIWindow? = nil) {
        let libsManager = LibsManager.shared
        libsManager.setCocoaJournal()
        libsManager.setupAnalytics()
        libsManager.setupAds()
        libsManager.setupTheme()
        libsManager.setupKafkaRefresh()
        libsManager.setupFLEX()
        libsManager.setupKeyboardManager()
        libsManager.setupActivityView()
        libsManager.setupDropDown()
        libsManager.setupToast()
    }
    
    ///配置日志格式
    func setCocoaJournal() {
        DDLog.add(DDTTYLogger.sharedInstance!) // TTY = Xcode console
//        DDLog.add(DDASLLogger.sharedInstance) // ASL = Apple System Logs

        let fileLogger: DDFileLogger = DDFileLogger() // File Logger
        fileLogger.rollingFrequency = TimeInterval(60*60*24)  // 24 hours
        fileLogger.logFileManager.maximumNumberOfLogFiles = 7
        DDLog.add(fileLogger)
    }
    
    ///配置分析、数据库、消息传递和崩溃报告等功能，可助您快速采取行动并专注于您的用户。
    func setupAnalytics() {
        FirebaseApp.configure()
        Mixpanel.initialize(token: Keys.mixpanel.apiKey)
//        Fabric.with([Crashlytics.self])
//        Fabric.sharedSDK().debug = false
//        analytics.register(provider: MixpanelProvider())
//        analytics.register(provider: FirebaseProvider())
    }
    
    ///配置广告
    func setupAds() {
        GADMobileAds.sharedInstance().start(completionHandler: nil)
    }
    
    ///配置主题
    func setupTheme() {
        themeService.rx
        .bind({ $0.statusBarStyle }, to: UIApplication.shared.rx.statusBarStyle)
        .disposed(by: rx.disposeBag)
    }
    
    ///配置下拉刷新
    func setupKafkaRefresh() {
        if let defaults = KafkaRefreshDefaults.standard() {
            defaults.headDefaultStyle = .replicatorAllen
            defaults.footDefaultStyle = .replicatorDot
            themeService.rx
                .bind({ $0.secondary }, to: defaults.rx.themeColor)
                .disposed(by: rx.disposeBag)
        }
    }
    
    ///配置调试工具 Debug view，分析网络请求
    func setupFLEX() {
        FLEXManager.shared.isNetworkDebuggingEnabled = true
    }
    
    ///配置键盘
    func setupKeyboardManager() {
        IQKeyboardManager.shared.enable = false
    }
    
    ///配置 loading 动画
    func setupActivityView() {
        NVActivityIndicatorView.DEFAULT_TYPE = .ballRotateChase
        NVActivityIndicatorView.DEFAULT_COLOR = UIColor.secondary()
    }
    
    ///配置 下拉view
    func setupDropDown() {
        themeService.attrsStream.subscribe(onNext: { (theme) in
            DropDown.appearance().backgroundColor = theme.primary
            DropDown.appearance().selectionBackgroundColor = theme.primaryDark
            DropDown.appearance().textColor = theme.text
            DropDown.appearance().selectedTextColor = theme.text
            DropDown.appearance().separatorColor = theme.separator
        }).disposed(by: rx.disposeBag)
    }
 
    ///配置 提示框
    func setupToast() {
        ToastManager.shared.isTapToDismissEnabled = true
        ToastManager.shared.position = .top
        var style = ToastStyle()
        style.backgroundColor = UIColor.Material.red
        style.messageColor = UIColor.Material.white
        style.imageSize = CGSize(width: 30, height: 30)
        ToastManager.shared.style = style
    }
    
}
