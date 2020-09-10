//
//  TableView.swift
//  AudioVisual
//
//  Created by winpower on 2020/8/18.
//  Copyright © 2020 yasuo. All rights reserved.
//

import UIKit

class TableView: UITableView {

    init () {
        super.init(frame: CGRect(), style: .grouped)
    }

    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        makeUI()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        makeUI()
    }

    func makeUI() {
        rowHeight = UITableView.automaticDimension
        estimatedRowHeight = 50
        sectionHeaderHeight = 40
        backgroundColor = .clear
        cellLayoutMarginsFollowReadableWidth = false
        keyboardDismissMode = .onDrag
        separatorColor = .clear
        separatorInset = UIEdgeInsets(top: 0, left: inset, bottom: 0, right: 0)
        tableHeaderView = View(height: 1)
        tableFooterView = UIView()
    }

}
