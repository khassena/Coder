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
    
    let staffTableView = StaffTableView()
    
    func setup() {
        addSubview(departmentCollectionView)
        addSubview(separetorbottomLine)
        addSubview(staffTableView)
        departmentCollectionView.translatesAutoresizingMaskIntoConstraints = false
        separetorbottomLine.translatesAutoresizingMaskIntoConstraints = false
        separetorbottomLine.backgroundColor = .systemGray
        staffTableView.translatesAutoresizingMaskIntoConstraints = false
        
        
        NSLayoutConstraint.activate([
            departmentCollectionView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            departmentCollectionView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            departmentCollectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            departmentCollectionView.heightAnchor.constraint(equalToConstant: 36.5),
            
            separetorbottomLine.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            separetorbottomLine.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            separetorbottomLine.topAnchor.constraint(equalTo: departmentCollectionView.bottomAnchor),
            separetorbottomLine.heightAnchor.constraint(equalToConstant: 0.33),
            
            staffTableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            staffTableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            staffTableView.topAnchor.constraint(equalTo: separetorbottomLine.bottomAnchor),
            staffTableView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
}
