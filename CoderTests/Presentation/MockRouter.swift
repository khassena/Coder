//
//  MockRouter.swift
//  CoderTests
//
//  Created by Amanzhan Zharkynuly on 19.02.2023.
//

import UIKit
@testable import Coder

class MockRouter: RouterProtocol {
    
    var staffNavigationController: UINavigationController?
    var favoriteNavigationController: UINavigationController?
    var assemblyBuilder: AssemblyBuilderProtocol?
    
    func initialViewController() -> UIViewController {
        return UIViewController()
    }
    
    func showSortScreen(view: SortViewProtocol?, staff: Staff?) {
        
    }
    
    func showProfileScreen(item: Person?, target: Target) {
        
    }
    
    func popToRootVC(target: Target) {
    
    }
    
}
