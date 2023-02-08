//
//  HeaderSectionView.swift
//  Coder
//
//  Created by Amanzhan Zharkynuly on 11.01.2023.
//

import UIKit

class HeaderSectionView: UIView {
    
    private let yearLabel: UILabel = HeaderSectionView.createYearLabel()
    private let leftLine: UIView = HeaderSectionView.createLineView()
    private let rightLine: UIView = HeaderSectionView.createLineView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        [leftLine, yearLabel, rightLine].forEach {
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        yearLabel.text = String(Date().currentYear + 1)
        
        NSLayoutConstraint.activate([
            
            yearLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            yearLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: Constants.HeaderView.yearPosition),
            
            leftLine.heightAnchor.constraint(equalToConstant: Constants.HeaderView.lineHeight),
            leftLine.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.HeaderView.leadingConstant),
            leftLine.widthAnchor.constraint(equalToConstant: Constants.HeaderView.lineWidth),
            leftLine.trailingAnchor.constraint(equalTo: yearLabel.leadingAnchor),
            leftLine.centerYAnchor.constraint(equalTo: yearLabel.centerYAnchor),
            
            rightLine.heightAnchor.constraint(equalToConstant: Constants.HeaderView.lineHeight),
            rightLine.leadingAnchor.constraint(equalTo: yearLabel.trailingAnchor),
            rightLine.widthAnchor.constraint(equalToConstant: Constants.HeaderView.lineWidth),
            rightLine.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Constants.HeaderView.trailingConstant),
            rightLine.centerYAnchor.constraint(equalTo: yearLabel.centerYAnchor)
        ])
    }
}

extension HeaderSectionView {
    
    static func createYearLabel() -> UILabel {
        let yearLabel = UILabel()
        yearLabel.textColor = Color.lightGray
        yearLabel.font = Fonts.yearFont
        yearLabel.contentMode = .scaleAspectFit
        yearLabel.textAlignment = .center
        return yearLabel
    }
    
    static func createLineView() -> UIView {
        let line = UIView()
        line.backgroundColor = Color.lightGray
        return line
    }
}
