//
//  StaffDataSourceProvider.swift
//  Coder
//
//  Created by Amanzhan Zharkynuly on 28.01.2023.
//

import UIKit

protocol StaffDataSourceProtocol: UITableViewDelegate, UITableViewDataSource {
    var staff: Staff? { get set }
    var favoriteStaff: Staff? { get set }
    var skeleton: Bool { get set }
    var showBirthday: Bool { get set }
}

class StaffDataSourceProvider: NSObject, StaffDataSourceProtocol {
    
    var staff: Staff?
    var favoriteStaff: Staff?
    var skeleton: Bool = true
    var showBirthday: Bool = false
    
    var presenter: StaffViewPresenterProtocol?
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if skeleton == true {
            return Constants.Staff.defaultItemsCount
        }
        
        if showBirthday == true {
            return section == .zero ? presenter?.items?.count ?? 0 : presenter?.itemsForSection?.count ?? 0
        }
        
        return presenter?.items?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: StaffTableViewCell.cell, for: indexPath) as? StaffTableViewCell else { return UITableViewCell()
        }
        if skeleton == true {
            cell.showSkeleton(skeleton)
            return cell
        }
        
        var item: Person!
        
        if showBirthday == false {
           item = presenter?.items?[indexPath.row]
        } else {
            item = indexPath.section == .zero ? presenter?.items?[indexPath.row] : presenter?.itemsForSection?[indexPath.row]
        }
        
        guard let avatarUrl = URL(string: item.avatarUrl) else {
            return UITableViewCell()
        }
        cell.showSkeleton(false)
        presenter?.getImage(with: avatarUrl, indexPath: indexPath)
        cell.showDateLabel(showBirthday)
        cell.setupValue(firstName: item.firstName,
                        lastName:  item.lastName,
                        userTag:   item.userTag.lowercased(),
                        position:  item.department.name,
                        birthdayDate:  item.birthdayDate ?? Date())
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.Staff.cellHeight
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return showBirthday ? 2 : 1
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        section != .zero ? HeaderSectionView() : nil
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        section != .zero ? Constants.HeaderView.heightForRow : .zero
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var relevantItem: Person?
        
        relevantItem = indexPath.section == .zero ? presenter?.items?[indexPath.row] : presenter?.itemsForSection?[indexPath.row]
        
        tableView.deselectRow(at: indexPath, animated: false)
        presenter?.routToProfileScreen(item: relevantItem)
        
    }
    
    
}
