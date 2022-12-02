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
    
    func setup() {
        addSubview(departmentCollectionView)
        departmentCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            departmentCollectionView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            departmentCollectionView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            departmentCollectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            departmentCollectionView.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
}
