//
//  FavoriteViewController.swift
//  Coder
//
//  Created by Amanzhan Zharkynuly on 29.01.2023.
//

import UIKit

class FavoriteViewController: UIViewController {
    
    // MARK: Casting super view to custom StaffRootView
    var rootView: FavoriteRootView {
        return self.view as! FavoriteRootView
    }
    
    var presenter: FavoritePresenterProtocol?
    
    override func loadView() {
        super.loadView()
        self.view = FavoriteRootView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        rootView.setup()
        setup()
        presenter?.getData()
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "dataBaseUpdated") , object: nil, queue: nil) { _ in
            self.presenter?.getData()
            self.rootView.favoriteTableView.reloadData()
        }
    }

}

private extension FavoriteViewController {
    
    func setup() {
        setNavigationBar()
        setDelegates()
    }
    
    func setNavigationBar() {
        navigationItem.largeTitleDisplayMode = .always
        title = "Favorites"
    }
    
    func setDelegates() {
        rootView.favoriteTableView.delegate = self
        rootView.favoriteTableView.dataSource = self
    }
    
}

extension FavoriteViewController: FavoriteViewProtocol {
    func networkFailure(error: Error) {
        print("parsing images in favoriteVC ended with error: \(error)")
    }
    
    func imageLoader(with image: UIImage, indexPath: IndexPath) {
        let cell = rootView.favoriteTableView.cellForRow(at: indexPath) as? StaffTableViewCell
        cell?.setImage(with: image)
    }
}

extension FavoriteViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter?.items?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: StaffTableViewCell.cell, for: indexPath) as? StaffTableViewCell,
              let item = presenter?.items?[indexPath.row],
              let avatarUrl = URL(string: item.avatarUrl),
              let presenter = presenter else { return UITableViewCell() }
        
        let isfavorite = presenter.checkIsFavorite(item: item)
        presenter.getImage(with: avatarUrl, indexPath: indexPath)
        cell.setupValue(firstName: item.firstName,
                        lastName:  item.lastName,
                        userTag:   item.userTag.lowercased(),
                        position:  item.department.name,
                        birthdayDate:  item.birthdayDate ?? Date(),
                        isFavorite: isfavorite)
        cell.showSkeleton(false)
        cell.showDateLabel(false)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.Staff.cellHeight
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

}

extension FavoriteViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var relevantItem: Person?
        
        relevantItem = presenter?.items?[indexPath.row]
        
        tableView.deselectRow(at: indexPath, animated: false)
        presenter?.routToProfileScreen(item: relevantItem)
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            self.presenter?.deleteItemFromRealm(indexPath: indexPath)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }

    }
    
}
