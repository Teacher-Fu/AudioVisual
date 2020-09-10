//
//  Configs.swift
//  AudioVisual
//
//  Created by winpower on 2020/7/29.
//  Copyright © 2020 yasuo. All rights reserved.
//

import UIKit
import Foundation

enum Keys {
    case github, mixpanel, adMob

    var apiKey: String {
        switch self {
        case .github: return "5a39979251c0452a9476bd45c82a14d8e98c3fb3"
        case .mixpanel: return "7e428bc407e3612f6d3a4c8f50fd4643"
        case .adMob: return "ca-app-pub-3940256099942544/2934735716"
        }
    }

    var appId: String {
        switch self {
        case .github: return "00cbdbffb01ec72e280a"
        case .mixpanel: return ""
        case .adMob: return ""  // See GADApplicationIdentifier in Info.plist
        }
    }
}

struct Configs {
    struct App {
        static let projectUrl = "https://github.com/AudioVisual"
        static let bundleIdentifier = "com.share.AudioVisual"
    }
    
    struct Network {
        static let useStaging = false  // set true for tests and generating screenshots with fastlane
        static let loggingEnabled = false
        static let githubBaseUrl = "https://api.github.com"
        static let trendingGithubBaseUrl = "https://github-trending-api.now.sh"
        static let githistoryBaseUrl = "https://github.githistory.xyz"
        static let starHistoryBaseUrl = "https://star-history.t9t.io"
        static let profileSummaryBaseUrl = "https://profile-summary-for-github.com"
    }
    
    struct BaseDimensions {
        static let inset: CGFloat = 10
        static let tabBarHeight: CGFloat = 58
        static let toolBarHeight: CGFloat = 66
        static let navBarWithStatusBarHeight: CGFloat = 64
        static let cornerRadius: CGFloat = 5
        static let borderWidth: CGFloat = 1
        static let buttonHeight: CGFloat = 40
        static let textFieldHeight: CGFloat = 40
        static let tableRowHeight: CGFloat = 40
        static let segmentedControlHeight: CGFloat = 36
    }
    
    struct Path {
        static let Documents = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        static let Tmp = NSTemporaryDirectory()
    }
    
    struct UserDefaultsKeys {
        static let bannersEnabled = "BannersEnabled"
    }
}
