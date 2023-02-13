//
//  PresentNetworkError.swift
//  Coder
//
//  Created by Amanzhan Zharkynuly on 19.01.2023.
//

import UIKit

final class PresentNetworkError {
    
    private lazy var window = UIApplication.shared.connectedScenes.map({ $0 as? UIWindowScene }).compactMap({ $0 }).first?.windows.last
    private lazy var top = CGAffineTransform(translationX: .zero, y: -300)
    private lazy var viewToShow = NetworkErrorView(frame: CGRect(x: .zero,
                                                                 y: .zero,
                                                                 width: window?.frame.size.width ?? 0,
                                                                 height: (window?.frame.size.height ?? 0) / 8))
}

// MARK: - Public Methods

extension PresentNetworkError {
   
    func presentError() {
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(self.handleGesture(gesture:)))
        swipeUp.direction = .up
        window?.addGestureRecognizer(swipeUp)
        window?.addSubview(viewToShow)
        Timer.scheduledTimer(withTimeInterval: 4, repeats: false) { _ in
            UIWindow.animate(withDuration: 0.4, delay: 0.0, options: [], animations: {
                self.viewToShow.transform = self.top
            }, completion: nil)
        }
    }
}

// MARK: - Action

@objc
private extension PresentNetworkError {
    
    func handleGesture(gesture: UISwipeGestureRecognizer) {
        if gesture.direction == UISwipeGestureRecognizer.Direction.up {
            UIWindow.animate(withDuration: 0.4, delay: 0.0, options: [], animations: {
                self.viewToShow.transform = self.top
            }, completion: nil)
        }
    }
}
