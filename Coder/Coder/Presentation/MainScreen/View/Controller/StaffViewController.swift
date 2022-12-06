//
//  MainViewController.swift
//  Coder
//
//  Created by Amanzhan Zharkynuly on 30.11.2022.
//

import UIKit

class StaffViewController: UIViewController, StaffViewProtocol {
    func networkSuccess() {
        print(presenter?.staff?.items[0].firstName ?? 0)
        print("S")
    }
    
    func networkFailure(error: Error) {
        print("F")
    }
    
    
    // MARK: Casting super view to custom StaffRootView
    var rootView: StaffRootView {
        return self.view as! StaffRootView
    }
    
    override func loadView() {
        super.loadView()
        self.view = StaffRootView()
    }
    
    var presenter: StaffViewPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.titleView = rootView.searchBar
        rootView.departmentCollectionView.register(DepartmentCollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        rootView.setup()
        rootView.departmentCollectionView.delegate = self
        rootView.departmentCollectionView.dataSource = self
    }
}

extension StaffViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let label = UILabel(frame: .zero)
        label.text = presenter?.departments[indexPath.row]
        label.sizeToFit()
        if label.text?.isEmpty == true {
            return CGSize(width: 20, height: collectionView.frame.height)
        } else {
            return CGSize(width: label.frame.width + 24, height: collectionView.frame.height)
        }
    }
}

extension StaffViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter?.departments.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? DepartmentCollectionViewCell else { return UICollectionViewCell() }
        cell.departmentLabel.text = presenter?.departments[indexPath.row]
        
        cell.setup(isSelected: presenter?.selectedDepartment == indexPath)
        return cell
    }
}

extension StaffViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        presenter?.selectedDepartment = indexPath
        collectionView.reloadData()
    }
}


