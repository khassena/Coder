//
//  SortStackView.swift
//  Coder
//
//  Created by Amanzhan Zharkynuly on 10.01.2023.
//

import UIKit

protocol SortStackViewDelegate: AnyObject {
    func didTap(button: SortModel)
}

class SortStackView: UIStackView {
    
    weak var delegate: SortStackViewDelegate?
    private var buttonCase: SortModel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    convenience init(views: [UIView], button: SortModel, view: SortStackViewDelegate) {
        self.init(arrangedSubviews: views)
        self.buttonCase = button
        self.delegate = view
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(didTap))
        self.addGestureRecognizer(recognizer)
    }
    
    private func setupViews() {
        translatesAutoresizingMaskIntoConstraints = false
        axis = .horizontal
        spacing = Constants.SortView.spacingStack
        alignment = .fill
        distribution = .fill
    }
    
    @objc func didTap() {
        guard let buttonCase = buttonCase else { return }
        delegate?.didTap(button: buttonCase)
    }
}
