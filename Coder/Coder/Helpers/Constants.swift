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
        static let dateOfBirthWidth: CGFloat = 30.0
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
        static let skeletonNameTop: CGFloat = 15.0
    }
    
    enum Gradient {
        static let start: CGPoint = CGPoint(x: 0.25, y: 0.5)
        static let end: CGPoint = CGPoint(x: 0.75, y: 0.5)
    }
    
    static let separateHeight: CGFloat = 0.34
    static let refreshViewRect = CGRect(x: UIScreen.main.bounds.width / 2.1, y: 20, width: 20, height: 20)
    static let strokeHeight: CGFloat = 2.0
    
    enum SearchBar {
        static let magnifierGray = UIImageView(image: UIImage(named: "magnifierGray"))
        static let magnifierBlack = UIImageView(image: UIImage(named: "magnifierBlack"))
        static let sortButtonNormal = UIImage(named: "sortButtonNormal")
        static let sortButtonSelected = UIImage(named: "sortButtonSelected")
        static let clear = UIImage(named: "clear")
        static let cornerRadius: CGFloat = 16.0
        static let backgroundColor = UIColor(red: 0.969, green: 0.969, blue: 0.973, alpha: 1)
        static let size = CGSize(width: 1, height: 40)
        static let placeholderColor = UIColor(red: 0.765, green: 0.765, blue: 0.776, alpha: 1)
        static let leftPositionAdjust = UIOffset(horizontal: 10, vertical: 0)
        static let rightPositionAdjust = UIOffset(horizontal: -10, vertical: 0)
        static let placeholderAttributes: [NSAttributedString.Key: Any] = [
            .font: Fonts.fontBirthDay,
            .foregroundColor: placeholderColor
        ]
        static let attributedString: NSAttributedString = .init(
            string: "Enter your name, tag, email...",
            attributes: placeholderAttributes
        )
        static let cancelAttributes: [NSAttributedString.Key: Any] = [
            .font: Fonts.fontDepBold,
            .foregroundColor: Color.purple
        ]
    }
    
    enum SearchError {
        static let image = UIImage(named: "errorMagnifier")
        static let blackColor = UIColor(red: 0.02, green: 0.02, blue: 0.063, alpha: 1)
        static let grayColor = UIColor(red: 0.591, green: 0.591, blue: 0.609, alpha: 1)
        static let imageTop: CGFloat = 80.0
        static let imageSize: CGFloat = 56.0
        static let messageTop: CGFloat = 8.0
        static let adviceTop: CGFloat = 12.0
    }
    
    enum SortView {
        static let cornerRadius: CGFloat = 10.0
        static let slideWidth: CGFloat = 56.0
        static let slideHeight: CGFloat = 4.0
        static let slideTop: CGFloat = 12.0
        static let textColor: UIColor = UIColor(red: 0.02, green: 0.02, blue: 0.063, alpha: 1)
        static let spacingStack: CGFloat = 14.0
        static let sortButtonFrame: CGFloat = 20.0
        static let alphabetTop: CGFloat = 35.0
        static let stackViewLeft: CGFloat = 18.0
        static let birthdayTop: CGFloat = 35.0
        static let unselectedImage = UIImage(named: "unselected")
        static let selectedImage = UIImage(named: "selected")
    }
    
    enum HeaderView {
        static let spacing: CGFloat = 12.0
        static let lineHeight: CGFloat = 1.0
        static let lineWidth: CGFloat = 72.0
        static let yearLabelHeight: CGFloat = 20.0
        static let leadingConstant: CGFloat = 20.0
        static let trailingConstant: CGFloat = -20.0
        static let heightForRow: CGFloat = 46.0
        static let yearPosition: CGFloat = -11.0
    }
    
    enum ProfileView {
        static let topViewBottom: CGFloat = 104.0
        static let cornerRadius = CGFloat(104 / 2)
        static let infoSpacing: CGFloat = 14.0
        static let starImage: UIImage = UIImage(named: "star") ?? UIImage()
        static let phoneImage: UIImage = UIImage(named: "phone") ?? UIImage()
        static let avatarTop: CGFloat = 72.0
        static let avatarSize: CGFloat = 104.0
        static let nameSpacing: CGFloat = 4.0
        static let nameTopAnch: CGFloat = 24.0
        static let departmentTopAnch: CGFloat = 12.0
        static let infoTopAnch: CGFloat = 27.0
        static let starIconWidth: CGFloat = 20.67
        static let separatorTop: CGFloat = 26.5
        static let separatorLeftAnch: CGFloat = 16.0
        static let separatorRightAnch: CGFloat = -16.0
        static let separatorHeight: CGFloat = 1.0
        static let phoneStackTopAnch: CGFloat = 21.0
        static let labelWidthControl: CGFloat = 100.0
    }
    
    enum APIError {
        static let ufoImage = UIImage(named: "UFO") ?? UIImage()
        static let titleText = "Some alien broke everything"
        static let subtitleText = "We will try to fix it quickly"
        static let buttonText = "Try again"
        static let imageCenterY = -50.0
        static let stackViewTop = 16.0
    }
    enum NetworkError {
        static let message = "I can't update the data.\nCheck your internet connection."
        static let frameX: CGFloat = 24.0
        static let width: CGFloat = 327.0
        static let height: CGFloat = 50.0
        static let backgroundColor = UIColor(red: 0.957, green: 0.263, blue: 0.212, alpha: 1)
    }
}

enum Color {
    static let purple = UIColor(red: 0.396, green: 0.204, blue: 1, alpha: 1)
    static let borderColor = UIColor(red: 0.969, green: 0.969, blue: 0.973, alpha: 1)
    static let darkGray = UIColor(red: 0.333, green: 0.333, blue: 0.361, alpha: 1)
    static let gray = UIColor(red: 0.591, green: 0.591, blue: 0.609, alpha: 1)
    static let lightGray = UIColor(red: 0.765, green: 0.765, blue: 0.776, alpha: 1)
    static let backgroundGray = UIColor(red: 0.969, green: 0.969, blue: 0.973, alpha: 1)
    static let black = UIColor(red: 0.02, green: 0.02, blue: 0.063, alpha: 1)
    static let shadow = UIColor(red: 0.086, green: 0.118, blue: 0.204, alpha: 0.04)
    static let darkBlue = UIColor(red: 0.396, green: 0.204, blue: 1, alpha: 1)
}

enum Fonts {
    static let fontDepBold = UIFont(name: "Inter-SemiBold", size: 15) ?? UIFont()
    static let fontDepMedium = UIFont(name: "Inter-Medium", size: 15) ?? UIFont()
    static let fontFullName = UIFont(name: "Inter-Medium", size: 16) ?? UIFont()
    static let fontUserTag = UIFont(name: "Inter-Medium", size: 14) ?? UIFont()
    static let fontPosition = UIFont(name: "Inter-Regular", size: 13) ?? UIFont()
    static let fontBirthDay = UIFont(name: "Inter-Regular", size: 15) ?? UIFont()
    static let messageFont = UIFont(name: "Inter-SemiBold", size: 17) ?? UIFont()
    static let adviceFont = UIFont(name: "Inter-Regular", size: 16) ?? UIFont()
    static let sortTitle = UIFont(name: "Inter-SemiBold", size: 20) ?? UIFont()
    static let sortFont = UIFont(name: "Inter-Medium", size: 16) ?? UIFont()
    static let yearFont = UIFont(name: "Inter-Medium", size: 15) ?? UIFont()
    static let nameFont = UIFont(name: "Inter-Bold", size: 24) ?? UIFont()
    static let profileFont = UIFont(name: "Inter-Regular", size: 17) ?? UIFont()
    static let profileInfo = UIFont(name: "Inter-Medium", size: 16) ?? UIFont()
    static let subtitleFont = UIFont(name: "Inter-Regular", size: 16) ?? UIFont()
    static let netErrorFont = UIFont(name: "Inter-Medium", size: 13) ?? UIFont()
}
