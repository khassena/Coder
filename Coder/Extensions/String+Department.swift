//
//  String+Department.swift
//  Coder
//
//  Created by Amanzhan Zharkynuly on 11.02.2023.
//

import Foundation

extension String {
    var convertToDepartment: Department {
        switch self {
        case "All":         return Department.all
        case "Android":     return Department.android
        case "iOS":         return Department.ios
        case "Design":      return Department.design
        case "Frontend":    return Department.frontend
        case "QA":          return Department.qa
        case "Backend":     return Department.backend
        case "Back office": return Department.backOffice
        case "HR":          return Department.hr
        case "Management":  return Department.management
        case "PR":          return Department.pr
        case "Support":     return Department.support
        case "Analytics":   return Department.analytics
        default:            return Department.end
        }
    }
}
