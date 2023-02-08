//
//  SearchErrorView.swift
//  Coder
//
//  Created by Amanzhan Zharkynuly on 24.12.2022.
//

import UIKit

class SearchErrorView: UIView {

    private let magnifier = SearchErrorView.magnifierImageView()
    private let message = SearchErrorView.message()
    private let advice = SearchErrorView.advice()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        [magnifier, message, advice].forEach {
            addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            magnifier.centerXAnchor.constraint(equalTo: centerXAnchor),
            magnifier.topAnchor.constraint(equalTo: topAnchor, constant: Constants.SearchError.imageTop),
            magnifier.widthAnchor.constraint(equalToConstant: Constants.SearchError.imageSize),
            magnifier.heightAnchor.constraint(equalToConstant: Constants.SearchError.imageSize),
            
            message.centerXAnchor.constraint(equalTo: centerXAnchor),
            message.topAnchor.constraint(equalTo: magnifier.bottomAnchor, constant: Constants.SearchError.messageTop),
            
            advice.centerXAnchor.constraint(equalTo: centerXAnchor),
            advice.topAnchor.constraint(equalTo: message.bottomAnchor, constant: Constants.SearchError.adviceTop)
        ])
    }
}

extension SearchErrorView {
    private static func magnifierImageView() -> UIImageView {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = Constants.SearchError.image
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }
    
    private static func message() -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "We didn't find anyone"
        label.textColor = Constants.SearchError.blackColor
        label.font = Fonts.messageFont
        return label
    }
    
    private static func advice() -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Try to adjust the request"
        label.textColor = Constants.SearchError.grayColor
        label.font = Fonts.adviceFont
        return label
    }
}
