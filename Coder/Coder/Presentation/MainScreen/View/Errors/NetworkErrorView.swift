//
//  NetworkErrorView.swift
//  Coder
//
//  Created by Amanzhan Zharkynuly on 19.01.2023.
//

import UIKit

class NetworkErrorView: UIView {

    private let errorLabel = NetworkErrorView.createLabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = Constants.NetworkError.backgroundColor
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    private func setupView() {
        addSubview(errorLabel)
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            errorLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.NetworkError.frameX),
            errorLabel.topAnchor.constraint(equalTo: topAnchor, constant: frame.midY - 10),
            errorLabel.widthAnchor.constraint(equalToConstant: Constants.NetworkError.width),
            errorLabel.heightAnchor.constraint(equalToConstant: Constants.NetworkError.height)
        ])
    }
}

private extension NetworkErrorView {
    
    static func createLabel() -> UILabel {
        let label = UILabel()
        label.text = Constants.NetworkError.message
        label.font = Fonts.netErrorFont
        label.textColor = .white
        label.numberOfLines = .zero
        return label
    }
}
