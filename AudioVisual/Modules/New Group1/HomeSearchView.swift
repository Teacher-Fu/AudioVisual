//
//  HomeSearchView.swift
//  AudioVisual
//
//  Created by winpower on 2020/8/27.
//  Copyright © 2020 yasuo. All rights reserved.
//

import UIKit

class HomeSearchView: View {
    
    lazy var logoButton: Button = {
        let view = Button()
        self.addSubview(view)
        view.snp.makeConstraints { (make) in
            make.width.height.equalTo(40)
            make.left.equalTo(10)
            make.centerY.equalToSuperview()
        }
        return view
    }()
    
    lazy var searchView: View = {
        let view = View()
        view.backgroundColor = ColorTheme.gray.color
        self.addSubview(view)
        view.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(0)
            make.left.equalTo(self.logoButton)
            make.right.equalTo(self.historyButton)
        }
        return view
    }()
    
    lazy var historyButton: Button = {
        let view = Button()
        self.addSubview(view)
        view.snp.makeConstraints { (make) in
            make.width.height.equalTo(40)
            make.right.equalTo(self.mainListButton.snp_leftMargin).offset(-10)
            make.centerY.equalToSuperview()
        }
        return view
    }()
    
    lazy var mainListButton: Button = {
        let view = Button()
        self.addSubview(view)
        view.snp.makeConstraints { (make) in
            make.width.height.equalTo(40)
            make.right.equalTo(-10)
            make.centerY.equalToSuperview()
        }
        return view
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        searchView.layer.cornerRadius = searchView.width/2
    }
    
}
