//
//  StaffTableViewCell.swift
//  Coder
//
//  Created by Amanzhan Zharkynuly on 06.12.2022.
//

import UIKit

class StaffTableViewCell: UITableViewCell {

    static let cell = "staffCell"
    
    private let personImage = StaffTableViewCell.imageView()
    
    var personFullName = StaffTableViewCell.label(color: .black, font: Fonts.fontFullName)
    
    private let personUserTag = StaffTableViewCell.label(color: Color.gray, font: Fonts.fontUserTag)
    
    private let personPosition = StaffTableViewCell.label(color: Color.darkGray, font: Fonts.fontPosition)
    
    private let personDateOfBirth = StaffTableViewCell.label(color: Color.darkGray, font: Fonts.fontBirthDay)
    
    private lazy var nameTagStackView = StaffTableViewCell.stackView(views:                                                                [personFullName,                                                                personUserTag],
                                                             axis: .horizontal,
                                                             alignment: .center)
    
    private lazy var namePositionStackView = StaffTableViewCell.stackView(views:
                                                                 [nameTagStackView,            personPosition],
                                                                  axis: .vertical,
                                                                  alignment: .leading)
    
    // MARK: Skeleton views
     let skeletonImage = StaffTableViewCell.skeletonImageView()
     let skeletonNameView = StaffTableViewCell.skeletonTempView(
                                        frame: Constants.Skeleton.nameFrame,
                                        radius: Constants.Skeleton.nameCornerRadius)
     let skeletonPositionView = StaffTableViewCell.skeletonTempView(
                                            frame: Constants.Skeleton.posFrame,
                                            radius:Constants.Skeleton.posCornerRadius)
    
    override func prepareForReuse() {
        personImage.image = Constants.Staff.defaultImage
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        
        setupSkeletonViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {

        [personImage, personDateOfBirth, namePositionStackView].forEach {
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
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
            personDateOfBirth.widthAnchor.constraint(greaterThanOrEqualToConstant: Constants.Staff.dateOfBirthWidth),
        ])
    }
    
    public func setImage(with image: UIImage) {
        personImage.image = image
    }
    
    public func setupValue(firstName: String,
                           lastName: String,
                           userTag: String,
                           position: String,
                           birthdayDate: Date) {
        personFullName.text = "\(firstName) \(lastName)"
        personUserTag.text = userTag
        personPosition.text = position
        personDateOfBirth.text = "\(birthdayDate.getNumOfMonth()) \(birthdayDate.getNameOfMonth())"
    }

    public func showSkeleton(_ bool: Bool) {
        skeletonImage.isHidden = !bool
        skeletonNameView.isHidden = !bool
        skeletonPositionView.isHidden = !bool
    }
    
    func showDateLabel(_ show: Bool) {
        personDateOfBirth.isHidden = !show
    }
    
}

// MARK: Creating Main Views

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
        label.textAlignment = .right
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

// MARK: Creating Sleleton Views
extension StaffTableViewCell {
    
    private static func addGradientLayer() -> CAGradientLayer {
        let gradient = CAGradientLayer()
        gradient.colors = [Constants.Skeleton.skeletonStart, Constants.Skeleton.skeletonEnd]
        gradient.locations = [0, 1]
        gradient.startPoint = Constants.Gradient.start
        gradient.endPoint = Constants.Gradient.end
        return gradient
    }
    
    private static func skeletonImageView() -> UIView {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.frame = Constants.Skeleton.imageFrame
        let layer = StaffTableViewCell.addGradientLayer()
        layer.frame = view.bounds
        layer.cornerRadius = Constants.Skeleton.imageCornerRadius
        view.layer.addSublayer(layer)
        return view
    }
    
    private static func skeletonTempView(frame: CGRect, radius: CGFloat) -> UIView {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.frame = frame
        let layer = StaffTableViewCell.addGradientLayer()
        layer.frame = view.bounds
        layer.cornerRadius = radius
        view.layer.addSublayer(layer)
        return view
    }
    
    private func setupSkeletonViews() {
        [skeletonImage, skeletonNameView, skeletonPositionView].forEach {
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        self.contentView.layoutMargins = Constants.Staff.edgeInsets
        let layoutMargin = self.contentView.layoutMarginsGuide
        
        NSLayoutConstraint.activate([
            skeletonImage.leadingAnchor.constraint(equalTo: layoutMargin.leadingAnchor),
            skeletonImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            skeletonImage.widthAnchor.constraint(equalToConstant: Constants.Staff.imageSize),
            skeletonImage.heightAnchor.constraint(equalToConstant: Constants.Staff.imageSize),
            
            skeletonNameView.leadingAnchor.constraint(equalTo: skeletonImage.trailingAnchor, constant: Constants.Staff.imageTrailing),
            skeletonNameView.topAnchor.constraint(equalTo: layoutMargin.topAnchor, constant: 15),
            skeletonNameView.widthAnchor.constraint(equalToConstant: Constants.Skeleton.nameViewWidth),
            skeletonNameView.heightAnchor.constraint(equalToConstant: Constants.Skeleton.nameViewHeight),
            
            skeletonPositionView.leadingAnchor.constraint(equalTo: skeletonImage.trailingAnchor, constant: Constants.Staff.imageTrailing),
            skeletonPositionView.topAnchor.constraint(equalTo: skeletonNameView.bottomAnchor, constant: Constants.Skeleton.spacing),
            skeletonPositionView.widthAnchor.constraint(equalToConstant: Constants.Skeleton.positionViewWidth),
            skeletonPositionView.heightAnchor.constraint(equalToConstant: Constants.Skeleton.positionViewHeight),
        ])
    }
}
