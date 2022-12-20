//
//  Constants.swift
//  Coder
//
//  Created by Amanzhan Zharkynuly on 30.11.2022.
//

import Foundation
import UIKit

enum Constants {
    enum API {
        static let baseUrl = "https://stoplight.io/mocks/kode-education/trainee-test/25143926/users"
        static let headers = [
            "Content-Type": "application/json",
            "Prefer": "code=200, dynamic=true"
        ]
    }
    
    static func departmentWidth(_ label: UILabel) -> CGFloat {
        if label.text?.isEmpty == true {
            return label.frame.width + 20.0
        } else {
            return label.frame.width + 24.0
        }
    }
    
    enum Department {
        static let viewHeight: CGFloat = 36.5
        static let selectedDefault: String = "All"
        static let edgeInsets = UIEdgeInsets(top: 8.0, left: 12.0, bottom: 8.0, right: 12.0)
    }
    
    enum Staff {
        static let defaultStaffCount: Int = 0
        static let cellHeight: CGFloat = 84.0
        static let edgeInsets = UIEdgeInsets(top: 0.0, left: 20, bottom: 0.0, right: 19.5)
        static let imageSize: CGFloat = 72.0
        static let imageTrailing: CGFloat = 16.0
        static let dateOfBirthLeading: CGFloat = -20.0
        static let dateOfBirthWidth: CGFloat = 40.0
        static let imageCornerRadius: CGFloat = 36.0
        static let stackViewSpacing: CGFloat = 4.0
        static let defaultImage: UIImage = UIImage(named: "goose.svg") ?? UIImage()
        static let defaultItemsCount: Int = 20
    }
    
    enum Skeleton {
        static let imageCornerRadius: CGFloat = 36.0
        static let nameCornerRadius: CGFloat = 8.0
        static let posCornerRadius: CGFloat = 6.0
        static let skeletonStart = UIColor(red: 0.955, green: 0.955, blue: 0.965, alpha: 1).cgColor
        static let skeletonEnd = UIColor(red: 0.979, green: 0.979, blue: 0.981, alpha: 1).cgColor
        static let nameViewWidth: CGFloat = 144.0
        static let nameViewHeight: CGFloat = 16.0
        static let positionViewWidth: CGFloat = 80.0
        static let positionViewHeight: CGFloat = 12.0
        static let spacing: CGFloat = 6.0
        static let imageFrame: CGRect = CGRect(x: 0, y: 0, width: 72, height: 72)
        static let nameFrame: CGRect = CGRect(x: 0, y: 0, width: 144, height: 16)
        static let posFrame: CGRect = CGRect(x: 0, y: 0, width: 80, height: 12)
    }
    
    enum Gradient {
        static let start: CGPoint = CGPoint(x: 0.25, y: 0.5)
        static let end: CGPoint = CGPoint(x: 0.75, y: 0.5)
    }
    
    static let separateHeight: CGFloat = 0.34
    static let refreshViewRect = CGRect(x: UIScreen.main.bounds.width / 2.1, y: 20, width: 20, height: 20)
    static let strokeHeight: CGFloat = 2.0
}

enum Color {
    static let purple = UIColor(red: 0.396, green: 0.204, blue: 1, alpha: 1)
    static let borderColor = UIColor(red: 0.969, green: 0.969, blue: 0.973, alpha: 1)
}

enum Fonts {
    static let fontDepBold: UIFont = UIFont(name: "Inter-SemiBold", size: 15) ?? UIFont()
    static let fontDepMedium: UIFont = UIFont(name: "Inter-Medium", size: 15) ?? UIFont()
    static let fontFullName: UIFont = UIFont(name: "Inter-Medium", size: 16) ?? UIFont()
    static let fontUserTag: UIFont = UIFont(name: "Inter-Medium", size: 14) ?? UIFont()
    static let fontPosition: UIFont = UIFont(name: "Inter-Regular", size: 13) ?? UIFont()
    static let fontBirthDay: UIFont = UIFont(name: "Inter-Regular", size: 15) ?? UIFont()
}
