//
//  APIModel.swift
//  Coder
//
//  Created by Amanzhan Zharkynuly on 30.11.2022.
//

import Foundation

struct Staff: Decodable {
    var items: [Person]
}

struct Person: Decodable, Equatable {
    let id: String
    let avatarUrl: String
    let firstName: String
    let lastName: String
    let userTag: String
    let department: Department
    let position: String
    let birthday: String
    let phone: String
}

enum Department: String, Decodable, CaseIterable {
    case start
    case all
    case android
    case ios
    case design
    case frontend
    case backend
    case qa
    case backOffice = "back_office"
    case hr
    case management
    case pr
    case support
    case analytics
    case end
}

extension Department {
    var name: String {
        switch self {
        case .start:      return ""
        case .all:        return "All"
        case .android:    return "Android"
        case .ios:        return "iOS"
        case .design:     return "Design"
        case .frontend:   return "Frontend"
        case .qa:         return "QA"
        case .backend:    return "Backend"
        case .backOffice: return "Back office"
        case .hr:         return "HR"
        case .management: return "Management"
        case .pr:         return "PR"
        case .support:    return "Support"
        case .analytics:  return "Analytics"
        case .end:        return ""
        }
    }
}

extension Person {
    var birthdayDate: Date? {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        return dateFormatter.date(from: birthday)
    }
}
