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
    
    var personFullName = StaffTableViewCell.label(color: .black, font: Fonts.fontFullName)
    
    let personUserTag = StaffTableViewCell.label(color: .systemGray, font: Fonts.fontUserTag)
    
    let personPosition = StaffTableViewCell.label(color: .systemGray, font: Fonts.fontPosition)
    
    let personDateOfBirth = StaffTableViewCell.label(color: .systemGray, font: Fonts.fontBirthDay)
    
    lazy var nameTagStackView = StaffTableViewCell.stackView(views: [personFullName,                                                                personUserTag],
                                                             axis: .horizontal,
                                                             alignment: .center)
    
    lazy var namePositionStackView = StaffTableViewCell.stackView(views:
                                                                    [nameTagStackView,            personPosition],
                                                                  axis: .vertical,
                                                                  alignment: .leading)
    
    override func prepareForReuse() {
        personImage.image = Constants.Staff.defaultImage
    }
    
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
            
            personDateOfBirth.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            personDateOfBirth.trailingAnchor.constraint(equalTo: layoutMargin.trailingAnchor),
            personDateOfBirth.widthAnchor.constraint(equalToConstant: Constants.Staff.dateOfBirthWidth),
        ])
    }
    
    public func setImage(with image: UIImage) {
        personImage.image = image
    }
    
    public func setupValue(firstName: String,
                           lastName: String,
                           userTag: String,
                           position: String,
                           birthday: String) {
        personFullName.text = "\(firstName) \(lastName)"
        personUserTag.text = userTag
        personPosition.text = position
        personDateOfBirth.text = birthday        
    }

}

extension StaffTableViewCell {
    
    private static func imageView() -> UIImageView {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = Constants.Staff.imageCornerRadius
        imageView.image = Constants.Staff.defaultImage
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }
    
    private static func label(color: UIColor, font: UIFont) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = color
        label.font = font
        return label
    }
    
    private static func stackView(views: [UIView], axis: NSLayoutConstraint.Axis, alignment: UIStackView.Alignment) -> UIStackView {
        var stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView = UIStackView(arrangedSubviews: views)
        stackView.axis = axis
        stackView.spacing = Constants.Staff.stackViewSpacing
        stackView.alignment = alignment
        stackView.distribution = .fill
        return stackView
    }
}
