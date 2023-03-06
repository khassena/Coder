//
//  MockProfileView.swift
//  CoderTests
//
//  Created by Amanzhan Zharkynuly on 19.02.2023.
//

import UIKit
@testable import Coder

class MockProfileView: ProfileViewProtocol {
    
    var catchPerson: Person?
    
    func dataReceived(item: Person, birthday: String, phone: String, age: String, isFavorite: Bool) {
        catchPerson = item
    }
    
    func imageReceived(image: UIImage) {
        // This method already checked
    }
    
    
}
