//
//  PresentingViewController.swift
//  Coder
//
//  Created by Amanzhan Zharkynuly on 09.01.2023.
//

import UIKit

class SortViewController: UIViewController {
    
    var hasSetPointOrigin = false
    var pointOrigin: CGPoint?
    
    private let slideIndicator: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .lightGray
        view.frame = CGRect(x: .zero, y: .zero, width: Constants.SortView.slideWidth, height: Constants.SortView.slideHeight)
        return view
    }()
    
    private let sortLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Fonts.sortTitle
        label.text = "Sorting"
        label.textColor = Constants.SortView.textColor
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panGestureRecognizerAction))
        view.addGestureRecognizer(panGesture)
        setupViews()
    }
    
    override func viewDidLayoutSubviews() {
        if !hasSetPointOrigin {
            hasSetPointOrigin = true
            pointOrigin = self.view.frame.origin
        }
    }
    
    private func setupViews() {
        [slideIndicator, sortLabel].forEach {
            view.addSubview($0)
        }
        slideIndicator.roundCorners(.allCorners, radius: Constants.SortView.cornerRadius)
        
        NSLayoutConstraint.activate([
            slideIndicator.topAnchor.constraint(equalTo: view.topAnchor, constant: Constants.SortView.slideTop),
            slideIndicator.widthAnchor.constraint(equalToConstant: Constants.SortView.slideWidth),
            slideIndicator.heightAnchor.constraint(equalToConstant: Constants.SortView.slideHeight),
            slideIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
        ])
    }
    
    @objc func panGestureRecognizerAction(sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: view)
        
        // Not allowing the user to drag the view upward
        guard translation.y >= 0 else { return }
        
        // setting x as 0 because we don't want users to move the frame side ways!! Only want straight up or down
        view.frame.origin = CGPoint(x: 0, y: self.pointOrigin!.y + translation.y)
        
        if sender.state == .ended {
            let dragVelocity = sender.velocity(in: view)
            if dragVelocity.y >= 1300 {
                self.dismiss(animated: true, completion: nil)
            } else {
                // Set back to original position of the view controller
                UIView.animate(withDuration: 0.3) {
                    self.view.frame.origin = self.pointOrigin ?? CGPoint(x: 0, y: 400)
                }
            }
        }
    }
    
}
