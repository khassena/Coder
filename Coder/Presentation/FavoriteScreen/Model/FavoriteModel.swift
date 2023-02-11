//
//  FavoriteModel.swift
//  Coder
//
//  Created by Amanzhan Zharkynuly on 11.02.2023.
//

import Foundation
import RealmSwift

struct FavoriteModel {
    var person: Results<FavoritePerson>!
    var items: [Person] = []
}

extension FavoriteModel {
    mutating func convertToItem() -> [Person]? {
        guard let person = person else { return nil }
        for each in person {
            let item = Person(
                id: each.id,
                avatarUrl: each.avatarUrl,
                firstName: each.firstName,
                lastName: each.lastName,
                userTag: each.userTag,
                department: each.department.convertToDepartment,
                position: each.position,
                birthday: each.birthday,
                phone: each.phone
            )
            items.append(item)
        }
        
        return items
    }
}

