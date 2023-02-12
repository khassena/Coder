//
//  MainTabBarController.swift
//  Coder
//
//  Created by Amanzhan Zharkynuly on 29.01.2023.
//

import UIKit

class MainTabBarController: UITabBarController {

    var navigationVC: UINavigationController?
    var staffVC: StaffViewController?
    var favoriteVC: FavoriteViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.tintColor = Color.purple
        tabBar.backgroundColor = Constants.SearchBar.backgroundColor
        tabBar.unselectedItemTintColor = .lightGray
    }
    
    private func setupViewControllers() {
        
    }

}
