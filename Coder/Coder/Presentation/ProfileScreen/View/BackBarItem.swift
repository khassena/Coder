//
//  BackBarItem.swift
//  Coder
//
//  Created by Amanzhan Zharkynuly on 16.01.2023.
//

import UIKit

class BackBarItem: UIBarButtonItem {
    
    convenience init(target: UINavigationController) {
        self.init()
        self.target = target
        setupView()
    }
    
    override init() {
        super.init()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setupView() {
        style = .plain
        image = UIImage(named: "backButton")
        tintColor = .black
        action = #selector(UINavigationController.popViewController(animated:))
    }
}
