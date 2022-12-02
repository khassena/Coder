//
//  DepartmentCollectionViewCell.swift
//  Coder
//
//  Created by Amanzhan Zharkynuly on 02.12.2022.
//

import UIKit

class DepartmentCollectionViewCell: UICollectionViewCell {
    
    public let departmentLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(departmentLabel)
        NSLayoutConstraint.activate([
            departmentLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            departmentLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            departmentLabel.topAnchor.constraint(equalTo: topAnchor),
            departmentLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
        
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
