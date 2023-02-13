//
//  ProfileRootView.swift
//  Coder
//
//  Created by Amanzhan Zharkynuly on 17.01.2023.
//

import UIKit

class ProfileRootView: UIView {

    let topBackView = ProfileRootView.createView()
    let avatarImage = ProfileRootView.createImageView()
    let nameLabel = ProfileRootView.createLabel(
        font: Fonts.nameFont,
        color: Color.black
    )
    let tagLabel = ProfileRootView.createLabel(
        font: Fonts.profileFont,
        color: Color.gray
    )
    let departmentLabel = ProfileRootView.createLabel(
        font: Fonts.fontPosition,
        color: Color.darkGray
    )
    lazy var nameStack = ProfileRootView.createStackView(
        views: [nameLabel, tagLabel],
        spacing: Constants.ProfileView.nameSpacing
    )
    let containerView = UIView()
    private let separatorView = UIView()
    let dateInfoStack = DateOfBirthView()
    let phoneInfoStack = PhoneView()
    
    func setupView() {
        [topBackView, nameStack, departmentLabel, containerView, dateInfoStack, separatorView, phoneInfoStack].forEach {
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        containerView.addSubview(avatarImage)
        avatarImage.translatesAutoresizingMaskIntoConstraints = false
        separatorView.backgroundColor = Color.borderColor
        let layoutMargin = self.layoutMarginsGuide
        
        NSLayoutConstraint.activate([
            topBackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            topBackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            topBackView.topAnchor.constraint(equalTo: topAnchor),
            topBackView.bottomAnchor.constraint(equalTo: avatarImage.bottomAnchor, constant: Constants.ProfileView.topViewBottom),
            
            
            containerView.centerXAnchor.constraint(equalTo: centerXAnchor),
            containerView.topAnchor.constraint(equalTo: topAnchor, constant: Constants.ProfileView.avatarTop),
            containerView.widthAnchor.constraint(equalToConstant: Constants.ProfileView.avatarSize),
            containerView.heightAnchor.constraint(equalToConstant: Constants.ProfileView.avatarSize),
            
            avatarImage.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            avatarImage.topAnchor.constraint(equalTo: containerView.topAnchor),
            avatarImage.widthAnchor.constraint(equalTo: containerView.widthAnchor),
            avatarImage.heightAnchor.constraint(equalTo: containerView.heightAnchor),
            
            nameStack.topAnchor.constraint(equalTo: avatarImage.bottomAnchor, constant: Constants.ProfileView.nameTopAnch),
            nameStack.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            departmentLabel.topAnchor.constraint(equalTo: nameStack.bottomAnchor, constant: Constants.ProfileView.departmentTopAnch),
            departmentLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            dateInfoStack.topAnchor.constraint(equalTo: topBackView.bottomAnchor, constant: Constants.ProfileView.infoTopAnch),
            dateInfoStack.leadingAnchor.constraint(equalTo: layoutMargin.leadingAnchor),
            dateInfoStack.trailingAnchor.constraint(equalTo: layoutMargin.trailingAnchor),
            
            separatorView.topAnchor.constraint(equalTo: dateInfoStack.bottomAnchor, constant: Constants.ProfileView.separatorTop),
            separatorView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.ProfileView.separatorLeftAnch),
            separatorView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Constants.ProfileView.separatorRightAnch),
            separatorView.heightAnchor.constraint(equalToConstant: Constants.ProfileView.separatorHeight),
            
            phoneInfoStack.topAnchor.constraint(equalTo: separatorView.bottomAnchor, constant: Constants.ProfileView.phoneStackTopAnch),
            phoneInfoStack.leadingAnchor.constraint(equalTo: layoutMargin.leadingAnchor),
            phoneInfoStack.trailingAnchor.constraint(equalTo: layoutMargin.trailingAnchor),
        ])
    }
}

extension ProfileRootView {
    func setData(firstName: String,
                 lastName: String,
                 tag: String,
                 department: String,
                 avatar: UIImage,
                 dateOfBirth: String,
                 yearsOld: String,
                 phoneNumber: String,
                 isFavorite: Bool) {
        nameLabel.text = "\(firstName) \(lastName)"
        tagLabel.text = tag
        departmentLabel.text = department
        avatarImage.image = avatar
        dateInfoStack.setData(dateOfBirth, yearsOld, isFavorite)
        phoneInfoStack.setData(phoneNumber)
    }
    
    func changeAvatar(image: UIImage) {
        avatarImage.image = image
    }
}

extension ProfileRootView {
    
    static func createView() -> UIView {
        let view = UIView()
        view.backgroundColor = Color.backgroundGray
        return view
    }
    
    static func createImageView() -> UIImageView {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.image = Constants.Staff.defaultImage
        imageView.layer.cornerRadius = Constants.ProfileView.cornerRadius
        return imageView
    }
    
    static func createLabel(font: UIFont, color: UIColor) -> UILabel {
        let label = UILabel()
        label.font = font
        label.textColor = color
        return label
    }
    
    static func createIcon(image: UIImage) -> UIImageView {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.image = image
        return imageView
    }
    
    static func createStackView(views: [UIView], spacing: CGFloat) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: views)
        stackView.axis = .horizontal
        stackView.spacing = spacing
        stackView.distribution = .fill
        stackView.alignment = .fill
        return stackView
    }
    
}
