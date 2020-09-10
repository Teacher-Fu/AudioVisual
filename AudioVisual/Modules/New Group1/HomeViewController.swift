//
//  HomeViewController.swift
//  AudioVisual
//
//  Created by winpower on 2020/8/19.
//  Copyright © 2020 yasuo. All rights reserved.
//

import UIKit

class HomeViewController: ViewController {
    
    lazy var searchView: HomeSearchView = {
        let view = HomeSearchView()
        view.snp.makeConstraints { (make) in
            make.width.equalToSuperview().inset(self.inset)
        }
        return view
    }()
    
    lazy var segmentControl:SegmentedControl = {
        let view = SegmentedControl()
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func makeUI() {
        
    }
    
    override func bindViewModel() {
        
    }
    
}

