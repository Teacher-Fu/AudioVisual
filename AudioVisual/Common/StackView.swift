//
//  StackView.swift
//  AudioVisual
//
//  Created by winpower on 2020/8/18.
//  Copyright © 2020 yasuo. All rights reserved.
//

import UIKit

class StackView: UIStackView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        makeUI()
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        makeUI()
    }
    
    func makeUI() {
        spacing = inset 
        axis = .vertical
        // self.distribution = .fill

        updateUI()
    }
    
    func updateUI() {
        setNeedsDisplay()
    }
}
