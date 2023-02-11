//
//  AssemblyBuilder.swift
//  Coder
//
//  Created by Amanzhan Zharkynuly on 21.01.2023.
//

import UIKit

protocol AssemblyBuilderProtocol {
    func createMainTabBar() -> UITabBarController
    func createMainScreen(router: RouterProtocol) -> UIViewController
    func createSortScreen(view: SortViewProtocol, router: RouterProtocol) -> UIViewController
    func createProfileScreen(router: RouterProtocol, item: Person?, navController: UINavigationController) -> UIViewController
    func createFavoriteScreen(router: RouterProtocol) -> UIViewController
}

class AssemblyMainBuilder: AssemblyBuilderProtocol {
    
    func createMainTabBar() -> UITabBarController {
        let tabBar = MainTabBarController()
        
        return tabBar
    }
    
    func createMainScreen(router: RouterProtocol) -> UIViewController {
        let view = StaffViewController()
        let networkService = NetworkService()
        let presenter = StaffPresenter(view: view, networkService: networkService, router: router)
        view.presenter = presenter
        return view
    }
    
    func createSortScreen(view: SortViewProtocol, router: RouterProtocol) -> UIViewController {
        let sortVC = SortViewController()
        let presenter = SortPresenter(view: view, router: router, sortVC: sortVC)
        sortVC.presenter = presenter
        sortVC.modalPresentationStyle = .custom
        sortVC.transitioningDelegate = view
        view.sortVC = presenter.sortVC
        return sortVC
    }
    
    func createProfileScreen(router: RouterProtocol, item: Person?, navController: UINavigationController) -> UIViewController {
        let view = ProfileViewController()
        let network = NetworkService()
        let presenter = ProfilePresenter(view: view, networkService: network, router: router)
        view.presenter = presenter
        view.navController = navController
        presenter.item = item
        return view
    }
    
    func createFavoriteScreen(router: RouterProtocol) -> UIViewController {
        let view = FavoriteViewController()
        let network = NetworkService()
        let presenter = FavoritePresenter(
            view: view,
            networkService: network,
            router: router
        )
        view.presenter = presenter
        return view
    }
}
