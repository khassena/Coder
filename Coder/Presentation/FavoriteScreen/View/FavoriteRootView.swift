//
//  FavoriteRootView.swift
//  Coder
//
//  Created by Amanzhan Zharkynuly on 10.02.2023.
//

import UIKit

class FavoriteRootView: UIView {

    let favoriteTableView = FavoriteTableView()
    
    func setup() {
        
        [favoriteTableView].forEach {
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            
            favoriteTableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            favoriteTableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            favoriteTableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            favoriteTableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

}
