//
//  StaffModel.swift
//  Coder
//
//  Created by Amanzhan Zharkynuly on 01.12.2022.
//

import Foundation

struct StaffModel {
    var searchText: String = ""
    var items: [Person]?
    var filteredItems: [Person]?
    var filteredSecondSection: [Person]? = nil
    var departments: [Department] = []
    var selectedDepartmentPath: IndexPath?
    var searching: Bool = false
    var sortModel: SortModel?
    var showBirthday: Bool = false
}

extension StaffModel {
    mutating func filteredData() -> [Person]? {
        filteredSecondSection = nil
        guard let selected = selectedDepartmentPath, departments[selected.row].name != Constants.Department.selectedDefault  else {
            filteredItems = self.items
            searchFilter()
            sortItems()
            return filteredItems
        }
        
        filteredItems = items?.filter({ person in
            person.department == departments[selected.row]
        }) as? [Person]
        
        searchFilter()
        sortItems()
        
        return filteredItems
    }
    
    mutating func searchFilter() {
        filteredItems = filteredItems?.filter ({
            $0.firstName.lowercased().prefix(searchText.count) == searchText ||
            $0.lastName.lowercased().prefix(searchText.count) == searchText ||
            $0.userTag.lowercased().prefix(searchText.count) == searchText
        })
    }
    
    private mutating func sortItems() {
        filteredSecondSection = nil
        guard let sortModel = sortModel else {
            filteredSecondSection = nil
            return
        }
        switch sortModel {
        case .alphabet:
            filteredItems = filteredItems?.sorted(by: {
                $0.firstName < $1.firstName
            })
            showBirthday = false
        case .birthday:
            
            filteredSecondSection = filteredItems?.filter({
                $0.birthdayDate?.getNextDate().getYear() ?? 0 > Date().currentYear
            }).sorted(by: { person1, person2 in
                person1.birthdayDate?.getNextDate().daysLeft() ?? 0 < person2.birthdayDate?.getNextDate().daysLeft() ?? 0
            })
            
            filteredItems = filteredItems?.sorted(by: { person1, person2 in
                person1.birthdayDate?.getNextDate().daysLeft() ?? 0 < person2.birthdayDate?.getNextDate().daysLeft() ?? 0
            }).filter({
                $0.birthdayDate?.getNextDate().getYear() == Date().currentYear
            })
            
            showBirthday = true
        case .none:
            filteredSecondSection = nil
            showBirthday = false
        }
    }
    
}
