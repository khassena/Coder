//
//  APIError.swift
//  Coder
//
//  Created by Amanzhan Zharkynuly on 19.01.2023.
//

import UIKit

class APIErrorView: UIView {
    
    private let imageView = APIErrorView.createImageView()
    private let titleView = APIErrorView.createLabel(
        font: Fonts.messageFont,
        color: Color.black,
        text: Constants.APIError.titleText
    )
    private let subtitleView = APIErrorView.createLabel(
        font: Fonts.messageFont,
        color: Color.gray,
        text: Constants.APIError.subtitleText
    )
    let tryAgainButton = APIErrorView.createButton(
        font: Fonts.subtitleFont,
        color: Color.darkBlue
    )
    private lazy var errorStackView = APIErrorView.createStackView(
        views: [titleView, subtitleView, tryAgainButton]
    )
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    private func setupView() {
        [imageView, errorStackView].forEach {
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: Constants.APIError.imageCenterY),
            errorStackView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: Constants.APIError.stackViewTop),
            errorStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            
        ])
    }

}

private extension APIErrorView {
    
    static func createImageView() -> UIImageView {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.image = Constants.APIError.ufoImage
        return imageView
    }
    
    static func createLabel(font: UIFont, color: UIColor, text: String) -> UILabel {
        let label = UILabel()
        label.font = font
        label.textColor = color
        label.text = text
        return label
    }
    
    static func createButton(font: UIFont, color: UIColor) -> UIButton {
        let button = UIButton(type: .system)
        button.titleLabel?.font = font
        button.setTitleColor(color, for: .normal)
        button.backgroundColor = .clear
        button.setTitle(Constants.APIError.buttonText, for: .normal)
        button.setTitle(Constants.APIError.buttonText, for: .highlighted)
        return button
    }
    
    static func createStackView(views: [UIView]) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: views)
        stackView.axis = .vertical
        stackView.spacing = 12.0
        stackView.distribution = .fill
        stackView.alignment = .fill
        return stackView
    }
}
