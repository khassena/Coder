//
//  DepartmentCollectionViewCell.swift
//  Coder
//
//  Created by Amanzhan Zharkynuly on 02.12.2022.
//

import UIKit

class DepartmentCollectionViewCell: UICollectionViewCell {
    
    static let cell = "departmentCell"
    
     let departmentLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .systemGray
        label.font = Fonts.fontDepMedium
        return label
    }()
    
    private let stroke: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isHidden = true
        view.backgroundColor = Color.purple
        return view
    }()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        stroke.isHidden = true
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        
        [departmentLabel, stroke].forEach {
            addSubview($0)
        }
        
        let layoutMargins = self.layoutMarginsGuide
        self.layoutMargins = Constants.Department.edgeInsets
        
        NSLayoutConstraint.activate([
            departmentLabel.leadingAnchor.constraint(equalTo: layoutMargins.leadingAnchor),
            departmentLabel.topAnchor.constraint(equalTo: layoutMargins.topAnchor),
            departmentLabel.bottomAnchor.constraint(equalTo: layoutMargins.bottomAnchor),
            
            stroke.heightAnchor.constraint(equalToConstant: Constants.strokeHeight),
            stroke.leadingAnchor.constraint(equalTo: leadingAnchor),
            stroke.trailingAnchor.constraint(equalTo: trailingAnchor),
            stroke.bottomAnchor.constraint(equalTo: bottomAnchor),
        
        ])
    }
    
    public func setValue(itemTitle: String?, selected: IndexPath?, indexPath: IndexPath) {
        
        departmentLabel.text = itemTitle
        
        if selected == nil,
           departmentLabel.text == Constants.Department.selectedDefault {
           setSelected(true)
        } else {
            setSelected(selected == indexPath)
        }
    }
    
    private func setSelected(_ isSelected: Bool) {
        if isSelected == true {
            stroke.isHidden = false
            departmentLabel.textColor = .black
            departmentLabel.font = Fonts.fontDepBold
        } else {
            stroke.isHidden = true
            departmentLabel.textColor = .systemGray
            departmentLabel.font = Fonts.fontDepMedium
        }
    }
    
}
