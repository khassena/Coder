//
//  ProfileModel.swift
//  Coder
//
//  Created by Amanzhan Zharkynuly on 16.01.2023.
//

import Foundation

struct ProfileModel {
    func getFormatted(date: Date?) -> String {
        guard let date = date else { return "" }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMMM yyyy"
        return formatter.string(from: date)
    }
    
    func getFormatted(phone: String) -> String {
        
        let pattern = "+7 (###) ### ## ##"
        let replacementCharacter: Character = "#"
        
        var pureNumber = phone.replacingOccurrences( of: "[^0-9]", with: "", options: .regularExpression)
        for index in 0 ..< pattern.count {
            guard index < pureNumber.count else { return pureNumber }
            let stringIndex = String.Index(utf16Offset: index, in: pattern)
            let patternCharacter = pattern[stringIndex]
            guard patternCharacter != replacementCharacter else { continue }
            pureNumber.insert(patternCharacter, at: stringIndex)
        }
        return pureNumber
    }
    
    func getFormatted(age: Date?) -> String {
        guard let age = age else { return "" }
        return "\(age.ageOfUser()) y.o"
    }
}
