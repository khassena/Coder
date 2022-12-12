//
//  MainViewController.swift
//  Coder
//
//  Created by Amanzhan Zharkynuly on 30.11.2022.
//

import UIKit

class StaffViewController: UIViewController {
    
    // MARK: Casting super view to custom StaffRootView
    var rootView: StaffRootView {
        return self.view as! StaffRootView
    }
    
    override func loadView() {
        super.loadView()
        self.view = StaffRootView()
    }
    
    var presenter: StaffViewPresenterProtocol?
    var staffNumber: Int = Constants.Staff.defaultStaffCount
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.titleView = rootView.searchBar
        rootView.setup()
        rootView.departmentCollectionView.delegate = self
        rootView.departmentCollectionView.dataSource = self
        rootView.staffTableView.delegate = self
        rootView.staffTableView.dataSource = self
    }
}

extension StaffViewController: StaffViewProtocol {
    func networkSuccess() {
        staffNumber = presenter?.staff?.items.count ?? 0
        rootView.staffTableView.reloadData()
    }
    
    func networkFailure(error: Error) {
        print("F")
    }
}

extension StaffViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let label = UILabel(frame: .zero)
        label.text = presenter?.departments[indexPath.row]
        label.sizeToFit()
        let itemWidth = Constants.departmentWidth(label)
        return CGSize(width: itemWidth, height: collectionView.frame.height)
    }
}

extension StaffViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter?.departments.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DepartmentCollectionViewCell.cell, for: indexPath) as? DepartmentCollectionViewCell else { return UICollectionViewCell() }
        
        cell.setValue(itemTitle: presenter?.departments[indexPath.row],
                   selected: presenter?.selectedDepartment,
                   indexPath: indexPath)

        return cell
    }
}

extension StaffViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        
        if presenter?.selectedDepartment == indexPath {
            presenter?.selectedDepartment = nil
        } else {
            presenter?.selectedDepartment = indexPath
        }
        collectionView.reloadData()
    }
}


extension StaffViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return staffNumber
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: StaffTableViewCell.cell, for: indexPath) as? StaffTableViewCell else { return UITableViewCell()
        }
        
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.Staff.cellHeight
    }
    
}

extension StaffViewController: UITableViewDelegate {
    
}
