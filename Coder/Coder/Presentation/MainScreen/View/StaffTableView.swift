//
//  StaffTableView.swift
//  Coder
//
//  Created by Amanzhan Zharkynuly on 01.12.2022.
//

import UIKit

class StaffTableView: UITableView {

    init() {
        super.init(frame: .zero, style: .plain)
        register(StaffTableViewCell.self, forCellReuseIdentifier: StaffTableViewCell.cell)
        showsVerticalScrollIndicator = false
//        preservesSuperviewLayoutMargins = true
//        self.separatorInset = .zero
//        self.preservesSuperviewLayoutMargins = false
//        self.layoutMargins = .zero
        separatorStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
