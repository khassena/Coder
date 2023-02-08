//
//  Router.swift
//  Coder
//
//  Created by Amanzhan Zharkynuly on 21.01.2023.
//

import UIKit

protocol RouterMain {
    var navigationController: UINavigationController? { get set }
    var assemblyBuilder: AssemblyBuilderProtocol? { get set }
}

protocol RouterProtocol: RouterMain {
    func initialViewController() -> UIViewController
    func showSortScreen(view: SortViewProtocol?, staff: Staff?)
    func showProfileScreen(item: Person?)
    func popToRootVC()
}

class Router: RouterProtocol {
    
    var navigationController: UINavigationController?
    var assemblyBuilder: AssemblyBuilderProtocol?
    
    init(navigationController: UINavigationController, assemblyBuilder: AssemblyBuilderProtocol) {
        self.navigationController = navigationController
        self.assemblyBuilder = assemblyBuilder
    }
    
    func initialViewController() -> UIViewController {
        if let navigationController = navigationController {
            guard let mainTabBar = assemblyBuilder?.createMainTabBar() as?
                    MainTabBarController,
                  let staffVC = assemblyBuilder?.createMainScreen(router: self) as? StaffViewController,
                  let _ = assemblyBuilder?.createSortScreen(view: staffVC, router: self) as? SortViewController,
                  let favoriteVC = assemblyBuilder?.createFavoriteScreen() as? FavoriteViewController else { return UIViewController() }
            navigationController.viewControllers = [staffVC]
            let navVC = UINavigationController(rootViewController: favoriteVC)
            navVC.title = "Favorite"
            navigationController.title = "Staff"
            navigationController.tabBarItem.image = UIImage(systemName: "list.bullet")
            navVC.tabBarItem.image = UIImage(systemName: "star.fill")
            mainTabBar.viewControllers = [navigationController, navVC]
            return mainTabBar
        }
        return UIViewController()
    }
    
    func showSortScreen(view: SortViewProtocol?, staff: Staff?) {
        if let navigationController = navigationController,
           let viewController = view?.sortVC {
            navigationController.present(viewController, animated: true)
        }
    }
    
    func showProfileScreen(item: Person?) {
        if let navigationController = navigationController {
            guard let profileViewController = assemblyBuilder?.createProfileScreen(router: self, item: item) else { return }
            navigationController.pushViewController(profileViewController, animated: true)
        }
    }
    
    func popToRootVC() {
        if let navigationController = navigationController {
            navigationController.popToRootViewController(animated: true)
        }
    }
}
