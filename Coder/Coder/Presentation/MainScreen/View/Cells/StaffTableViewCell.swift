//
//  StaffTableViewCell.swift
//  Coder
//
//  Created by Amanzhan Zharkynuly on 06.12.2022.
//

import UIKit

class StaffTableViewCell: UITableViewCell {

    static let cell = "staffCell"
    
    let personImage = StaffTableViewCell.imageView()
    
    var personFullName = StaffTableViewCell.label(color: .black)
    
    let personUserTag = StaffTableViewCell.label(color: .systemGray)
    
    let personPosition = StaffTableViewCell.label(color: .systemGray)
    
    let personDateOfBirth = StaffTableViewCell.label(color: .systemGray)
    
    lazy var nameTagStackView = StaffTableViewCell.stackView(views: [personFullName,                                                                personUserTag],
                                                             axis: .horizontal)
    
    lazy var namePositionStackView = StaffTableViewCell.stackView(views:
                                                                    [nameTagStackView,            personPosition],
                                                                  axis: .vertical)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {

        contentView.addSubview(personImage)
        contentView.addSubview(personDateOfBirth)
        contentView.addSubview(namePositionStackView)
        
        personImage.translatesAutoresizingMaskIntoConstraints = false
        namePositionStackView.translatesAutoresizingMaskIntoConstraints = false
        personDateOfBirth.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.layoutMargins = Constants.Staff.edgeInsets
        let layoutMargin = self.contentView.layoutMarginsGuide
        
        NSLayoutConstraint.activate([
            personImage.leadingAnchor.constraint(equalTo: layoutMargin.leadingAnchor),
            personImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            personImage.widthAnchor.constraint(equalToConstant: Constants.Staff.imageSize),
            personImage.heightAnchor.constraint(equalToConstant: Constants.Staff.imageSize),
            
            namePositionStackView.leadingAnchor.constraint(equalTo: personImage.trailingAnchor, constant: Constants.Staff.imageTrailing),
            namePositionStackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            namePositionStackView.trailingAnchor.constraint(equalTo: personDateOfBirth.leadingAnchor, constant: Constants.Staff.dateOfBirthLeading),
            namePositionStackView.heightAnchor.constraint(equalToConstant: Constants.Staff.namePositionHeight),
            
            personDateOfBirth.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            personDateOfBirth.trailingAnchor.constraint(equalTo: layoutMargin.trailingAnchor),
            personDateOfBirth.widthAnchor.constraint(equalToConstant: Constants.Staff.dateOfBirthWidth),
        ])
    }
    
}

extension StaffTableViewCell {
    
    private static func imageView() -> UIImageView {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = Constants.Staff.imageCornerRadius
        imageView.backgroundColor = Color.purple
        
        return imageView
    }
    
    private static func label(color: UIColor) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = color
        return label
    }
    
    private static func stackView(views: [UIView], axis: NSLayoutConstraint.Axis) -> UIStackView {
        var stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView = UIStackView(arrangedSubviews: views)
        stackView.axis = axis
        stackView.spacing = Constants.Staff.stackViewSpacing
        stackView.alignment = .leading
        stackView.distribution = .fill
        return stackView
    }
}
