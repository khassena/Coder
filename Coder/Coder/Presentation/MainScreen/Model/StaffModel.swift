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
    var departments: [Department] = []
    var selectedDepartmentPath: IndexPath?
    var searching: Bool = false
    var sortModel: SortModel?
}

extension StaffModel {
    mutating func filteredData() -> [Person]? {
        
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
        guard let sortModel = sortModel else { return }
        
        switch sortModel {
        case .alphabet:
            filteredItems = filteredItems?.sorted(by: {
                $0.firstName < $1.firstName
            })
        case .birthday:
            sortByDate()
        }
    }

    private mutating func sortByDate() {
        
    }
    
    
}
