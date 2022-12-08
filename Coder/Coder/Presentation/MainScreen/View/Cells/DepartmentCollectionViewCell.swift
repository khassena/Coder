//
//  DepartmentCollectionViewCell.swift
//  Coder
//
//  Created by Amanzhan Zharkynuly on 02.12.2022.
//

import UIKit

class DepartmentCollectionViewCell: UICollectionViewCell {
    
    static let cell = "departmentCell"
    
    public let departmentLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .systemGray
        return label
    }()
    
    public let stroke: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 0.396, green: 0.204, blue: 1, alpha: 1)
        return view
    }()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        stroke.isHidden = true
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //stroke.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: 5.0)
        //departmentLabel.center = self.center
        addSubview(departmentLabel)
        //guard departmentLabel.text?.isEmpty == false else { return }
        addSubview(stroke)
        stroke.isHidden = true
        let layoutMargins = self.layoutMarginsGuide
        self.layoutMargins = UIEdgeInsets(top: 8.0, left: 12.0, bottom: 8.0, right: 12.0)
        NSLayoutConstraint.activate([
            departmentLabel.leadingAnchor.constraint(equalTo: layoutMargins.leadingAnchor),
            departmentLabel.topAnchor.constraint(equalTo: layoutMargins.topAnchor),
            departmentLabel.bottomAnchor.constraint(equalTo: layoutMargins.bottomAnchor),
            
            stroke.heightAnchor.constraint(equalToConstant: 2),
            stroke.leadingAnchor.constraint(equalTo: leadingAnchor),
            stroke.trailingAnchor.constraint(equalTo: trailingAnchor),
            stroke.bottomAnchor.constraint(equalTo: bottomAnchor),
        
        ])
        
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setSelected(isSelected: Bool) {
        if isSelected == true {
            stroke.isHidden = false
        } else {
            stroke.isHidden = true
        }
    }
    
}
