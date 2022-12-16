//
//  MainRootView.swift
//  Coder
//
//  Created by Amanzhan Zharkynuly on 01.12.2022.
//

import UIKit

class StaffRootView: UIView {

    let searchBar = SearchBar()
    
    let departmentCollectionView = DepartmentCollectionView()
    let separetorbottomLine = UIView()
    let refreshControl = UIRefreshControl()
    let circularSpinner = CircularSpinner(frame: Constants.refreshViewRect)
    lazy var staffTableView = StaffTableView(refreshControl: refreshControl)
    
    func setup() {
        addSubview(departmentCollectionView)
        addSubview(separetorbottomLine)
        addSubview(staffTableView)
        departmentCollectionView.translatesAutoresizingMaskIntoConstraints = false
        separetorbottomLine.translatesAutoresizingMaskIntoConstraints = false
        separetorbottomLine.backgroundColor = .systemGray
        staffTableView.translatesAutoresizingMaskIntoConstraints = false
        refreshControl.addSubview(circularSpinner)
        refreshControl.tintColor = .clear
        
        NSLayoutConstraint.activate([
            departmentCollectionView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            departmentCollectionView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            departmentCollectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            departmentCollectionView.heightAnchor.constraint(equalToConstant: Constants.Department.viewHeight),
            
            separetorbottomLine.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            separetorbottomLine.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            separetorbottomLine.topAnchor.constraint(equalTo: departmentCollectionView.bottomAnchor),
            separetorbottomLine.heightAnchor.constraint(equalToConstant: Constants.separateHeight),
            
            staffTableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            staffTableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            staffTableView.topAnchor.constraint(equalTo: separetorbottomLine.bottomAnchor),
            staffTableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
}
