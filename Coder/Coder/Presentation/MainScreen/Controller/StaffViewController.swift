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
    
    var dataSourceProvider: StaffDataSourceProtocol?
    var presenter: StaffViewPresenterProtocol?
    private var skeleton = true
    weak var sortVC: SortViewController?
    private lazy var showBirthday = false
    private lazy var sortButtonDidClick = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.titleView = rootView.searchBar
        rootView.setup()
        setDelegates()
        networkMonitoring()
        hideKeyboardWhenTappedAround()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillHide(notification: Notification) {
        endSearching()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        rootView.setupRefreshAnimation()
        setTarget()
        rootView.staffTableView.reloadData()
    }
    
    private func setTarget() {
        rootView.refreshControl.addTarget(self, action: #selector(pulledToRefresh), for: .valueChanged)
        rootView.apiErrorView.tryAgainButton.addTarget(self, action: #selector(tryAgainConnectionButton), for: .touchUpInside)
    }
    
    private func setDelegates() {
        rootView.departmentCollectionView.delegate = self
        rootView.departmentCollectionView.dataSource = self
        rootView.staffTableView.delegate = dataSourceProvider
        rootView.staffTableView.dataSource = dataSourceProvider
        rootView.searchBar.delegate = self
    }
    
    @objc private func pulledToRefresh() {
        presenter?.getData()
        rootView.refreshControl.layer.removeAllAnimations()
        rootView.refreshControl.endRefreshing()
    }
    
    @objc private func tryAgainConnectionButton() {
        presenter?.getData()
    }
    
    func searchBarBookmarkButtonClicked(_ searchBar: UISearchBar) {
        presenter?.routToSortScreen(view: self , staff: presenter?.staff)
    }
    
    func networkMonitoring() {
        NetworkMonitor.shared.isConnected == true ? rootView.setErrorView(error: false) : rootView.setErrorView(error: true)
        
        NetworkMonitor.shared.stopMonitoring()
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
        dataSourceProvider?.skeleton = false
        rootView.setErrorView(error: false)
        rootView.staffTableView.reloadData()
    }
    
    func imageLoader(with image: UIImage, indexPath: IndexPath) {
        let cell = rootView.staffTableView.cellForRow(at: indexPath) as? StaffTableViewCell
        cell?.setImage(with: image)
    }
    
    func networkFailure(error: Error) {
        PresentNetworkError().presentError()
    }
    
    func showBirthdaySelected(_ show: Bool) {
        showBirthday = show
        dataSourceProvider?.showBirthday = show
    }
}

extension StaffViewController: SortViewProtocol {
    func sortBy(_ button: SortModel) {
        presenter?.filterTableView(searchText: nil, sort: button)
        switch button {
        case .none:
            rootView.searchBar.sortButtonNormalState()
        default:
            rootView.searchBar.sortButtonSelectedState()
        }
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
        endSearching()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        endSearching()
    }
    
    func endSearching() {
        rootView.searchBar.searchTextField.leftView = Constants.SearchBar.magnifierGray
        rootView.searchBar.showsCancelButton = false
        rootView.searchBar.text = nil
        presenter?.filterTableView(searchText: nil, sort: presenter?.sortModel)
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

extension StaffViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        rootView.departmentCollectionView.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        endSearching()
        rootView.searchBar.endEditing(true)
    }
}

