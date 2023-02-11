//
//  FavoriteDataModel.swift
//  Coder
//
//  Created by Amanzhan Zharkynuly on 09.02.2023.
//

import Foundation
import RealmSwift

class FavoritePerson: Object {
    @objc dynamic var id: String = ""
    @objc dynamic var avatarUrl: String = ""
    @objc dynamic var firstName: String = ""
    @objc dynamic var lastName: String = ""
    @objc dynamic var userTag: String = ""
    @objc dynamic var department: String = ""
    @objc dynamic var position: String = ""
    @objc dynamic var birthday: String = ""
    @objc dynamic var phone: String = ""
}

