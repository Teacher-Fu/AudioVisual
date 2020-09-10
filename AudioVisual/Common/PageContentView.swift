//
//  PageContentView.swift
//  AudioVisual
//
//  Created by winpower on 2020/8/28.
//  Copyright © 2020 yasuo. All rights reserved.
//

import UIKit

class PageContentView: UIView {
    
    private var childVCs: [UIViewController]
    private weak var parentVC: UIViewController?
    private lazy var scrollView: UIScrollView = {
        let view = UIScrollView(frame: self.bounds)
        view.isPagingEnabled = true
        view.showsHorizontalScrollIndicator = false
        view.bounces = false
        return view
    }()

    init(frame: CGRect, childVCs: [UIViewController], parentVC: UIViewController) {
        self.childVCs = childVCs
        self.parentVC = parentVC
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


extension PageContentView {
    private func makeUI() {
        for (index,childVC) in childVCs.enumerated() {
            parentVC?.addChild(childVC)
            childVC.view.frame = CGRect(x: self.frame.size.width * CGFloat(index), y: self.frame.origin.y, width: self.frame.size.width, height: self.frame.size.height)
        }
        addSubview(scrollView)
    }
}
