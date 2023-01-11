//
//  SortViewController.swift
//  Coder
//
//  Created by Amanzhan Zharkynuly on 30.12.2022.
//

import UIKit

class PresentationViewController: UIPresentationController {
    
    let dimmView = UIView()
    var tapGestureRecognizer: UITapGestureRecognizer = UITapGestureRecognizer()
    
    override init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?) {        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
        dimmView.backgroundColor = .darkGray
        tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissController))
        dimmView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.dimmView.isUserInteractionEnabled = true
        self.dimmView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    override var frameOfPresentedViewInContainerView: CGRect {
        CGRect(origin: CGPoint(x: 0, y: self.containerView!.frame.height * 0.5),
               size: CGSize(width: self.containerView!.frame.width, height: self.containerView!.frame.height *
                            0.6))
    }
    
    override func presentationTransitionWillBegin() {
        self.dimmView.alpha = 0
        self.containerView?.addSubview(dimmView)
        self.presentedViewController.transitionCoordinator?.animate(alongsideTransition: { (UIViewControllerTransitionCoordinatorContext) in
            self.dimmView.alpha = 0.7
        }, completion: { (UIViewControllerTransitionCoordinatorContext) in })
    }
    
    override func dismissalTransitionWillBegin() {
        self.presentedViewController.transitionCoordinator?.animate(alongsideTransition: { (UIViewControllerTransitionCoordinatorContext) in
            self.dimmView.alpha = 0
        }, completion: { (UIViewControllerTransitionCoordinatorContext) in
            self.dimmView.removeFromSuperview()
        })
    }
    
    override func containerViewWillLayoutSubviews() {
        super.containerViewWillLayoutSubviews()
        presentedView!.roundCorners([.topLeft, .topRight], radius: 22)
    }
    
    override func containerViewDidLayoutSubviews() {
        super.containerViewDidLayoutSubviews()
        presentedView?.frame = frameOfPresentedViewInContainerView
        dimmView.frame = containerView!.bounds
    }
    
    @objc func dismissController(){
        self.presentedViewController.dismiss(animated: true, completion: nil)
    }
}

extension UIView {
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners,
                                cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}


