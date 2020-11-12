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
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func makeUI() {
        searchView.snp.makeConstraints { (make) in
            make.width.equalToSuperview().inset(self.inset)
            make.left.right.equalTo(0)
            make.height.equalTo(120)
            
        }
    }
    
    override func bindViewModel() {
        
    }
    
}

