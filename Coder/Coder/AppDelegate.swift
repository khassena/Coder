//
//  AppDelegate.swift
//  Coder
//
//  Created by Amanzhan Zharkynuly on 30.11.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .white
        let net = NetworkService()
        let view = StaffViewController()
        let presenter = StaffPresenter(view: view, networkService: net)
        view.presenter = presenter
        let navController = UINavigationController(rootViewController: view)
        navController.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navController.navigationBar.shadowImage = UIImage()
        window?.rootViewController = navController
        window?.makeKeyAndVisible()
        return true
    }

}

