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
    func initialViewController()
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
    
    func initialViewController() {
        if let navigationController = navigationController {
            guard let staffViewController = assemblyBuilder?.createMainScreen(router: self) as? StaffViewController,
                  let _ = assemblyBuilder?.createSortScreen(view: staffViewController, router: self) as? SortViewController else { return }
            navigationController.viewControllers = [staffViewController]
        }
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
