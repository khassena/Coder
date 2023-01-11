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
    private var skeleton = true
    private lazy var sortController = SortViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.titleView = rootView.searchBar
        rootView.setup()
        rootView.departmentCollectionView.delegate = self
        rootView.departmentCollectionView.dataSource = self
        rootView.staffTableView.delegate = self
        rootView.staffTableView.dataSource = self
        rootView.searchBar.delegate = self
        rootView.refreshControl.addTarget(self, action: #selector(pulledToRefresh), for: .valueChanged)
    }
    
    @objc private func pulledToRefresh() {
        presenter?.getData()
        rootView.refreshControl.layer.removeAllAnimations()
        rootView.refreshControl.endRefreshing()
    }
    
    func searchBarBookmarkButtonClicked(_ searchBar: UISearchBar) {
        sortController.modalPresentationStyle = .custom
        sortController.transitioningDelegate = self
        sortController.presenter?.staff = presenter?.staff
        let presenterSort = SortPresenter(view: self)
        sortController.presenter = presenterSort
        present(sortController, animated: true)
    }
}

extension StaffViewController: UIViewControllerTransitioningDelegate {
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        PresentationViewController(presentedViewController: presented, presenting: presenting)
    }
}

extension StaffViewController: StaffViewProtocol {
    
    func networkSuccess() {
        self.skeleton = false
        rootView.staffTableView.reloadData()
    }
    
    func imageLoader(with image: UIImage, indexPath: IndexPath) {
        let cell = rootView.staffTableView.cellForRow(at: indexPath) as? StaffTableViewCell
        cell?.setImage(with: image)
    }
    
    func networkFailure(error: Error) {
        print("Network Fail")
    }
}

extension StaffViewController: SortViewProtocol {
    func sortBy(_ button: SortModel) {
        presenter?.filterTableView(searchText: nil, sort: button)
        rootView.searchBar.setImage(Constants.SearchBar.sortButtonSelected, for: .bookmark, state: .normal)
        rootView.staffTableView.reloadData()
    }
}

extension StaffViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        rootView.searchBar.searchTextField.leftView = Constants.SearchBar.magnifierBlack
        rootView.searchBar.showsCancelButton = true
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        presenter?.filterTableView(searchText: searchText, sort: nil)
        rootView.setErrorView(show: presenter?.items?.isEmpty)
        rootView.staffTableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        rootView.searchBar.searchTextField.leftView = Constants.SearchBar.magnifierGray
        rootView.searchBar.showsCancelButton = false
        rootView.searchBar.text = nil
        presenter?.filterTableView(searchText: nil, sort: nil)
        rootView.setErrorView(show: false)
        rootView.searchBar.endEditing(true)
        rootView.staffTableView.reloadData()
    }
}

extension StaffViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let label = UILabel(frame: .zero)
        label.text = presenter?.departments[indexPath.row].name
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
        
        cell.setValue(itemTitle: presenter?.departments[indexPath.row].name,
                      selected: presenter?.selectedDepartmentPath,
                      indexPath: indexPath)

        return cell
    }
}

extension StaffViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        
        if presenter?.selectedDepartmentPath == indexPath ||
            presenter?.departments[indexPath.row].name == "" {
            presenter?.selectedDepartmentPath = nil
        } else {
            presenter?.selectedDepartmentPath = indexPath
        }
        collectionView.reloadData()
        rootView.staffTableView.reloadData()
        
    }
}


extension StaffViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if skeleton == true {
            return Constants.Staff.defaultItemsCount
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
        
        
        guard let items = presenter?.items?[indexPath.row],
              let avatarUrl = URL(string: items.avatarUrl) else {
            return UITableViewCell()
        }
        cell.showSkeleton(false)
        presenter?.getImage(with: avatarUrl, indexPath: indexPath)
        cell.setupValue(firstName: items.firstName,
                        lastName:  items.lastName,
                        userTag:   items.userTag.lowercased(),
                        position:  items.department.name,
                        birthdayDate:  items.birthdayDate ?? Date())
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.Staff.cellHeight
    }
    
}

extension StaffViewController: UITableViewDelegate {
    
}
