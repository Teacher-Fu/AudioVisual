//
//  TakeAVVC.swift
//  AudioVisual
//
//  Created by winpower on 2020/8/18.
//  Copyright © 2020 yasuo. All rights reserved.
//

import UIKit

enum PhotoQualitySegments: Int {
    case speed, balanced, quality
    var title: String {
        switch self {
        case .speed: return R.string.localizable.takeAVSpeedSegmentsTitle.key.localized()
        case .balanced: return R.string.localizable.takeAVBalancedSegmentsTitle.key.localized()
        case .quality: return R.string.localizable.takeAVQualitySegmentsTitle.key.localized()
        }
    }
}

class TakeAVVC: UIViewController {
    
    lazy var setConfigStackView: StackView = {
        let subviews: [UIView] = []
        let view = StackView(arrangedSubviews: subviews)
        return view
    }()
    
    lazy var photoQualityStackView: StackView = {
        let subviews: [UIView] = []
        let view = StackView(arrangedSubviews: subviews)
        return view
    }()
    
    lazy var setTakeModelStackView: StackView = {
        let subviews: [UIView] = []
        let view = StackView(arrangedSubviews: subviews)
        return view
    }()
    
    lazy var photoQualitySegmentedControl: SegmentedControl = {
        let titles: [String] = [PhotoQualitySegments.speed.title,PhotoQualitySegments.balanced.title,PhotoQualitySegments.quality.title]
        let segmentControl = SegmentedControl(sectionTitles: titles)
        return segmentControl
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    

}
