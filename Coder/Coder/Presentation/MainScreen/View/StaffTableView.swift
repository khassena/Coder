//
//  StaffTableView.swift
//  Coder
//
//  Created by Amanzhan Zharkynuly on 01.12.2022.
//

import UIKit

class StaffTableView: UITableView {

    convenience init(refreshControl: UIRefreshControl) {
        self.init()
        self.refreshControl = refreshControl
    }
    
    init() {
        super.init(frame: .zero, style: .plain)
        register(StaffTableViewCell.self, forCellReuseIdentifier: StaffTableViewCell.cell)
        showsVerticalScrollIndicator = false
        separatorStyle = .none
        sectionFooterHeight = 0
        sectionHeaderTopPadding = 22
        print(sectionHeaderTopPadding)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
