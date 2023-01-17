//
//  PhoneView.swift
//  Coder
//
//  Created by Amanzhan Zharkynuly on 17.01.2023.
//

import UIKit

class PhoneView: UIStackView {

    lazy var phoneNumber = ProfileRootView.createLabel(
        font: Fonts.profileFont,
        color: Color.black
    )
    private lazy var phoneIcon = ProfileRootView.createIcon(
        image: Constants.ProfileView.phoneImage
    )
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
    
}
