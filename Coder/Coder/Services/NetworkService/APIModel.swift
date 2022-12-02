//
//  APIModel.swift
//  Coder
//
//  Created by Amanzhan Zharkynuly on 30.11.2022.
//

import Foundation

struct Staff: Decodable {
    let staff: [Person]
}

struct Person: Decodable {
    let id: String
    let avatarUrl: String
    let firstName: String
    let lastName: String
    let userTag: String
    let department: Department
}

enum Department: String, Decodable, CaseIterable {
    case All
    case android
    case ios
    case design
    case management
    case qa
    case backOffice = "back_office"
    case frontend
    case hr
    case pr
    case backend
    case support
    case analytics
}
