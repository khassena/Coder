//
//  PhoneView.swift
//  Coder
//
//  Created by Amanzhan Zharkynuly on 17.01.2023.
//

import UIKit

protocol PhoneViewDelegate: AnyObject {
    func didTapToCall(phoneNumber: String, _ stackView: PhoneView)
}

class PhoneView: UIStackView {

    lazy var phoneNumber = ProfileRootView.createLabel(
        font: Fonts.profileFont,
        color: Color.black
    )
    private lazy var phoneIcon = ProfileRootView.createIcon(
        image: Constants.ProfileView.phoneImage
    )
    
    weak var delegate: PhoneViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(didTap))
        self.addGestureRecognizer(recognizer)
    }
    
    private func setupView() {
        [phoneIcon, phoneNumber].forEach {
            addArrangedSubview($0)
        }
        
        axis = .horizontal
        spacing = Constants.ProfileView.infoSpacing
        distribution = .fill
        alignment = .fill
        
        NSLayoutConstraint.activate([
            phoneIcon.widthAnchor.constraint(equalToConstant: Constants.ProfileView.starIconWidth),
            phoneNumber.widthAnchor.constraint(greaterThanOrEqualToConstant: Constants.ProfileView.labelWidthControl)
        ])
    }
    
    func setData(_ phone: String) {
        self.phoneNumber.text = phone
    }
    
    @objc func didTap() {
        delegate?.didTapToCall(phoneNumber: self.phoneNumber.text ?? "", self)
    }
}

