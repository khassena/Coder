//
//  DateOfBirthView.swift
//  Coder
//
//  Created by Amanzhan Zharkynuly on 17.01.2023.
//

import UIKit

class DateOfBirthView: UIStackView {

    let dateOfBirth = ProfileRootView.createLabel(
        font: Fonts.profileFont,
        color: Color.black
    )
    let yearsOld = ProfileRootView.createLabel(
        font: Fonts.profileFont,
        color: Color.gray
    )
    private let starIcon = ProfileRootView.createIcon(
        image: Constants.ProfileView.starImage
    )
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        [starIcon, dateOfBirth, yearsOld].forEach {
            addArrangedSubview($0)
        }
        axis = .horizontal
        spacing = Constants.ProfileView.infoSpacing
        distribution = .fill
        alignment = .fill
        
        NSLayoutConstraint.activate([
            dateOfBirth.widthAnchor.constraint(greaterThanOrEqualToConstant: Constants.ProfileView.labelWidthControl),
            starIcon.widthAnchor.constraint(equalToConstant: Constants.ProfileView.starIconWidth)
        ])
    }
    
    func setData(_ dateOfBirth: String, _ yearsOld: String) {
        self.dateOfBirth.text = dateOfBirth
        self.yearsOld.text = yearsOld
    }

}
