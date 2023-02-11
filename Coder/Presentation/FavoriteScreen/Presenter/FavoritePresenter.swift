//
//  FavoritePresenter.swift
//  Coder
//
//  Created by Amanzhan Zharkynuly on 11.02.2023.
//

import Foundation
import RealmSwift

protocol FavoriteViewProtocol: AnyObject {
    func imageLoader(with image: UIImage, indexPath: IndexPath)
    func networkFailure(error: Error)
}

protocol FavoritePresenterProtocol: AnyObject {
    init(view: FavoriteViewProtocol, networkService: NetworkServiceProtocol, router: RouterProtocol)
    var savedData: FavoritePerson? { get set }
    var items: [Person]? { get set }
    func getData()
    func getImage(with url: URL, indexPath: IndexPath)
    func deleteItemFromDB(indexPath: IndexPath)
    func routToProfileScreen(item: Person?) 
}

class FavoritePresenter: FavoritePresenterProtocol {

    lazy var realm = try! Realm()
    
    weak var view: FavoriteViewProtocol?
    let networkService: NetworkServiceProtocol
    var router: RouterProtocol?
    var savedData: FavoritePerson?
    var items: [Person]? 
    
    required init(view: FavoriteViewProtocol, networkService: NetworkServiceProtocol, router: RouterProtocol) {
        self.view = view
        self.networkService = networkService
        self.router = router
        getData()
    }
    
    func getData() {
        var model = FavoriteModel()
        model.person = realm.objects(FavoritePerson.self)
        items = model.convertToItem()
    }
    
    func getImage(with url: URL, indexPath: IndexPath) {
        networkService.fetchImage(with: url) { [weak self] result in
            switch result {
            case .success(let image):
                DispatchQueue.main.async {
                    self?.view?.imageLoader(with: image, indexPath: indexPath)
                }
            case .failure(let error):
                self?.view?.networkFailure(error: error)
            }
            
        }
    }
    
    func deleteItemFromDB(indexPath: IndexPath) {
        let deleteObject = realm.objects(FavoritePerson.self)[indexPath.row]

        do{
            try realm.write({
                realm.delete(deleteObject)
            })
        }catch let error {
            print(error.localizedDescription)
        }
    }
    
    func routToProfileScreen(item: Person?) {
        router?.showProfileScreen(item: item, target: .favorite)
    }
    
    
}
