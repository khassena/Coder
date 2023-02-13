//
//  FavoriteTableView.swift
//  Coder
//
//  Created by Amanzhan Zharkynuly on 10.02.2023.
//

import UIKit

class FavoriteTableView: UITableView {

    init() {
        super.init(frame: .zero, style: .plain)
        register(StaffTableViewCell.self, forCellReuseIdentifier: StaffTableViewCell.cell)
        showsVerticalScrollIndicator = false
        separatorStyle = .none
        sectionFooterHeight = 0
//        sectionHeaderTopPadding = 22
        backgroundColor = .white
        keyboardDismissMode = .onDrag
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
