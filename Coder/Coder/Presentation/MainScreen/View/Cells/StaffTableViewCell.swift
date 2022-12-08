//
//  StaffTableViewCell.swift
//  Coder
//
//  Created by Amanzhan Zharkynuly on 06.12.2022.
//

import UIKit

class StaffTableViewCell: UITableViewCell {

    static let cell = "staffCell"
    
    let personImage: UIImageView = StaffTableViewCell.imageView()
    
    var personFullName = StaffTableViewCell.label(color: .black)
    
    let personUserTag = StaffTableViewCell.label(color: .systemGray)
    
    let personPosition = StaffTableViewCell.label(color: .systemGray)
    
    let personDateOfBirth = StaffTableViewCell.label(color: .systemGray)
    
    lazy var nameTagStackView = StaffTableViewCell.stackView(views:
                                                                [personFullName, personUserTag],
                                                             axis: .horizontal)
    
    lazy var namePositionStackView = StaffTableViewCell.stackView(views:
                                                                    [nameTagStackView, personPosition],
                                                                  axis: .vertical)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .white
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        personFullName.text = "Amanzhan Khassen"
        personUserTag.text = "jk"
        personPosition.text = "Position"
        personDateOfBirth.text = "Date"
        
        contentView.addSubview(personImage)
        contentView.addSubview(personDateOfBirth)
        contentView.addSubview(namePositionStackView)
        
        personImage.translatesAutoresizingMaskIntoConstraints = false
        namePositionStackView.translatesAutoresizingMaskIntoConstraints = false
        personDateOfBirth.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.layoutMargins = UIEdgeInsets(top: 0.0, left: 20, bottom: 0.0, right: 19.5)
        let layoutMargin = self.contentView.layoutMarginsGuide
        
        NSLayoutConstraint.activate([
            personImage.leadingAnchor.constraint(equalTo: layoutMargin.leadingAnchor),
            personImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            personImage.widthAnchor.constraint(equalToConstant: 72.0),
            personImage.heightAnchor.constraint(equalToConstant: 72.0),
            
            namePositionStackView.leadingAnchor.constraint(equalTo: personImage.trailingAnchor, constant: 16),
            namePositionStackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            namePositionStackView.trailingAnchor.constraint(equalTo: personDateOfBirth.leadingAnchor, constant: -20),
            namePositionStackView.heightAnchor.constraint(equalToConstant: 40),
            
            personDateOfBirth.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            personDateOfBirth.trailingAnchor.constraint(equalTo: layoutMargin.trailingAnchor),
            personDateOfBirth.widthAnchor.constraint(equalToConstant: 40),
        ])
    }
    
}

extension StaffTableViewCell {
    
    static func imageView() -> UIImageView {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 36
        imageView.backgroundColor = .brown
        
        return imageView
    }
    
    static func label(color: UIColor) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = color
        return label
    }
    
    static func stackView(views: [UIView], axis: NSLayoutConstraint.Axis) -> UIStackView {
        var stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView = UIStackView(arrangedSubviews: views)
        stackView.axis = axis
        stackView.spacing = 4
        stackView.alignment = .leading
        stackView.distribution = .fill
        return stackView
    }
}
