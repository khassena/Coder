//
//  Router.swift
//  Coder
//
//  Created by Amanzhan Zharkynuly on 21.01.2023.
//

import UIKit

protocol RouterMain {
    var staffNavigationController: UINavigationController? { get set }
    var favoriteNavigationController: UINavigationController? { get set }
    var assemblyBuilder: AssemblyBuilderProtocol? { get set }
}

protocol RouterProtocol: RouterMain {
    func initialViewController() -> UIViewController
    func showSortScreen(view: SortViewProtocol?, staff: Staff?)
    func showProfileScreen(item: Person?, target: Target)
    func popToRootVC(target: Target)
}

class Router: RouterProtocol {
    
    var staffNavigationController: UINavigationController?
    var favoriteNavigationController: UINavigationController?
    var assemblyBuilder: AssemblyBuilderProtocol?
    
    init(staffNavigationController: UINavigationController,
         favoriteNavigationController: UINavigationController,
         assemblyBuilder: AssemblyBuilderProtocol) {
        self.staffNavigationController = staffNavigationController
        self.favoriteNavigationController = favoriteNavigationController
        self.assemblyBuilder = assemblyBuilder
    }
    
    func initialViewController() -> UIViewController {
        if let staffNavigationController = staffNavigationController,
           let favoriteNavigationController = favoriteNavigationController {
            guard let mainTabBar = assemblyBuilder?.createMainTabBar() as?
                    MainTabBarController,
                  let staffVC = assemblyBuilder?.createMainScreen(router: self) as? StaffViewController,
                  let _ = assemblyBuilder?.createSortScreen(view: staffVC, router: self) as? SortViewController,
                  let favoriteVC = assemblyBuilder?.createFavoriteScreen(router: self) as? FavoriteViewController else { return UIViewController() }
            
            staffNavigationController.viewControllers = [staffVC]
            favoriteNavigationController.viewControllers = [favoriteVC]
            favoriteNavigationController.title = "Favorite"
            staffNavigationController.title = "Staff"
            staffNavigationController.tabBarItem.image = UIImage(systemName: "list.bullet")
            favoriteNavigationController.tabBarItem.image = UIImage(systemName: "star.fill")
            mainTabBar.viewControllers = [staffNavigationController, favoriteNavigationController]
            
            return mainTabBar
        }
        return UIViewController()
    }
    
    func showSortScreen(view: SortViewProtocol?, staff: Staff?) {
        if let navigationController = staffNavigationController,
           let viewController = view?.sortVC {
            navigationController.present(viewController, animated: true)
        }
    }
    
    func showProfileScreen(item: Person?, target: Target) {
        switch target {
        case .staff:
            if let navController = staffNavigationController {
                guard let profileViewController = assemblyBuilder?.createProfileScreen(router: self, item: item, navController: navController) else { return }
                navController.pushViewController(profileViewController, animated: true)
            }
        case .favorite:
            if let navController = favoriteNavigationController {
                guard let profileViewController = assemblyBuilder?.createProfileScreen(router: self, item: item, navController: navController) else { return }
                navController.pushViewController(profileViewController, animated: true)
            }
        }
        
    }
    
    func popToRootVC(target: Target) {
        if let navigationController = staffNavigationController {
            navigationController.popToRootViewController(animated: true)
        }
    }
}
