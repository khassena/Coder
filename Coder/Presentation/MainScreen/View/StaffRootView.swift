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
    let searchErrorView = SearchErrorView()
    let apiErrorView = APIErrorView()
    
    func setupRefreshAnimation() {
        refreshControl.addSubview(circularSpinner)
        circularSpinner.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setup() {
        
        [departmentCollectionView, separetorbottomLine, staffTableView, searchErrorView, apiErrorView].forEach {
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        departmentCollectionView.backgroundColor = .white
        
        
        separetorbottomLine.backgroundColor = .systemGray
        refreshControl.tintColor = .clear
        
        searchErrorView.isHidden = true
        
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
            staffTableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            searchErrorView.leadingAnchor.constraint(equalTo: leadingAnchor),
            searchErrorView.topAnchor.constraint(equalTo: separetorbottomLine.bottomAnchor),
            searchErrorView.trailingAnchor.constraint(equalTo: trailingAnchor),
            searchErrorView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            apiErrorView.topAnchor.constraint(equalTo: topAnchor),
            apiErrorView.leadingAnchor.constraint(equalTo: leadingAnchor),
            apiErrorView.trailingAnchor.constraint(equalTo: trailingAnchor),
            apiErrorView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func setErrorView(show: Bool?) {
        searchErrorView.isHidden = !(show ?? false)
    }
    
    func setErrorView(error: Bool) {
        apiErrorView.isHidden = !error
        searchBar.isHidden = error
    }
    
}
