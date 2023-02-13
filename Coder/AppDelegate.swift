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
        
        let staffNavigationVC = UINavigationController()
        let favoriteNavigationVC = UINavigationController()
        
        [staffNavigationVC, favoriteNavigationVC].forEach {
            $0.navigationBar.setBackgroundImage(UIImage(), for: .default)
            $0.navigationBar.shadowImage = UIImage()
        }
        
        let assemblyBuilder = AssemblyMainBuilder()
        let router = Router(staffNavigationController: staffNavigationVC,
                            favoriteNavigationController: favoriteNavigationVC,
                            assemblyBuilder: assemblyBuilder)
        let mainTabBarVC = router.initialViewController()
        window?.rootViewController = mainTabBarVC
        window?.makeKeyAndVisible()
        launchCheckingNetworkConnection()
        return true
    }

    func launchCheckingNetworkConnection() {
        NetworkMonitor.shared.startMonitoring()
    }
}

