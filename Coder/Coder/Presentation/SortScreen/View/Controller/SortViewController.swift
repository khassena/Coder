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
    var presenter: SortViewPresenterProtocol?
    
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
    
    private let byAlphabet = SortViewController.createLabel(text: "By alphabet")
    private let sortButtonAlph = SortViewController.createSortButton()
    private let byBirthday = SortViewController.createLabel(text: "By birthday")
    private let sortButtonBirth = SortViewController.createSortButton()
    
    private lazy var alphabetStackView = SortStackView(views: [sortButtonAlph, byAlphabet], button: .alphabet, view: self)
    private lazy var birthdayStackView = SortStackView(views: [sortButtonBirth, byBirthday], button: .birthday, view: self)
    
    
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
        [slideIndicator, sortLabel, alphabetStackView, birthdayStackView].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        slideIndicator.roundCorners(.allCorners, radius: Constants.SortView.cornerRadius)
        sortButtonAlph.image = Constants.SortView.unselectedImage
        sortButtonBirth.image = Constants.SortView.unselectedImage
        
        NSLayoutConstraint.activate([
            slideIndicator.topAnchor.constraint(equalTo: view.topAnchor, constant: Constants.SortView.slideTop),
            slideIndicator.widthAnchor.constraint(equalToConstant: Constants.SortView.slideWidth),
            slideIndicator.heightAnchor.constraint(equalToConstant: Constants.SortView.slideHeight),
            slideIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            sortLabel.topAnchor.constraint(equalTo: slideIndicator.bottomAnchor, constant: Constants.SortView.slideTop),
            sortLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            alphabetStackView.topAnchor.constraint(equalTo: sortLabel.bottomAnchor, constant: Constants.SortView.alphabetTop),
            alphabetStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.SortView.stackViewLeft),
            
            birthdayStackView.topAnchor.constraint(equalTo: alphabetStackView.bottomAnchor, constant: Constants.SortView.birthdayTop),
            birthdayStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.SortView.stackViewLeft)
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

extension SortViewController: SortStackViewDelegate {
    
    func didTap(button: SortModel) {
        presenter?.didTapSortButton(button)
        switch button {
        case .alphabet:
            sortButtonAlph.image = Constants.SortView.selectedImage
            sortButtonBirth.image = Constants.SortView.unselectedImage
        case .birthday:
            sortButtonBirth.image = Constants.SortView.selectedImage
            sortButtonAlph.image = Constants.SortView.unselectedImage
        }
        self.dismiss(animated: true, completion: nil)
    }
}

extension SortViewController {
    private static func createLabel(text: String) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = text
        label.font = Fonts.sortFont
        return label
    }
    
    private static func createSortButton() -> UIImageView {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
//        imageView.image = Constants.SortView.unselectedImage
        imageView.frame = CGRect(x: .zero, y: .zero, width: Constants.SortView.sortButtonFrame, height: Constants.SortView.sortButtonFrame)
        return imageView
    }
    
    
}
