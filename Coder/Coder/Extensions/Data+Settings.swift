//
//  Data+Settings.swift
//  Coder
//
//  Created by Amanzhan Zharkynuly on 11.01.2023.
//

import Foundation

var calendarCurrent = currentDate()

func currentDate() -> Calendar {
    let calendar = Calendar.current
    return calendar
}

extension Date {
    func getNumOfMonth() -> Int {
        return calendarCurrent.component(.day, from: self)
    }
    
    func getNameOfMonth() -> String {
        let date = self
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM"
        let monthString = formatter.string(from: date)
        return monthString.lowercased()
//        return calendarCurrent.monthSymbols[calendarCurrent.component(.month, from: self) - 1]
    }
    
    func getNextDate() -> Date {
        let today = calendarCurrent.startOfDay(for: Date())
        let date = calendarCurrent.startOfDay(for: self)
        let component = calendarCurrent.dateComponents([.day, .month], from: date)
        if calendarCurrent.dateComponents([.day, .month, .year], from: today) == calendarCurrent.dateComponents([.day, .month, .year], from: date) {
            return Date()
        }
        
        return calendarCurrent.nextDate(after: today,
                                        matching: component,
                                        matchingPolicy: .nextTimePreservingSmallerComponents) ?? Date()
    }
    
    func daysLeft() -> Int {
        let today = calendarCurrent.startOfDay(for: Date())
        guard let daysLeft = calendarCurrent.dateComponents([.day], from: today, to: self).day else { return 0 }
        return daysLeft - 1
    }
}
