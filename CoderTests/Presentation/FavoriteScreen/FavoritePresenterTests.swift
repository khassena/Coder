//
//  FavoritePresenterTests.swift
//  CoderTests
//
//  Created by Amanzhan Zharkynuly on 19.02.2023.
//

import XCTest
import RealmSwift
@testable import Coder

class FavoritePresenterTests: XCTestCase {
    
    var view: FavoriteViewProtocol!
    var presenter: FavoritePresenterProtocol!
    var networkService: NetworkServiceProtocol!
    var router: RouterProtocol!

    override func setUpWithError() throws {
        router = MockRouter()
        view = MockFavoriteView()
        networkService = MockNetworkService()
        presenter = FavoritePresenter(
            view: view,
            networkService: networkService,
            router: router
        )
        var uniqueConfiguration = Realm.Configuration.defaultConfiguration
        uniqueConfiguration.inMemoryIdentifier = NSUUID().uuidString
        Realm.Configuration.defaultConfiguration = uniqueConfiguration
        let realm = try! Realm()
        presenter.realm = realm
        addToRealm()
    }

    override func tearDownWithError() throws {
        view = nil
        presenter = nil
        networkService = nil
        router = nil
    }
    
    func addToRealm() {
        let data = FavoritePerson()
        data.id = "0"
        data.avatarUrl = "http://"
        data.firstName = "Foo"
        data.lastName = "Foo"
        data.department = ""
        data.position = "po"
        data.userTag = "tt"
        data.birthday = "1999-02-01"
        data.phone = "430-738-7821"
        
        do {
            try presenter.realm?.write {
                presenter.realm?.add(data)
            }
        } catch {
            print(error)
        }
    }
    
    func testGetDataFromRealm() {
        // Given
        
        let person = Person(
            id: "0",
            avatarUrl: "http://",
            firstName: "Foo",
            lastName: "Foo",
            userTag: "tt",
            department: .start,
            position: "po",
            birthday: "1999-02-01",
            phone: "430-738-7821"
        )
        
        // When
        presenter.getData()
        
        // Then
        XCTAssertTrue(presenter.checkIsFavorite(item: person))
    }
    
    func testDeleteItemFromRealm() {
        // Given
        let mockIndexPath = IndexPath(arrayLiteral: 1, 0)
        let person = Person(
            id: "0",
            avatarUrl: "http://",
            firstName: "Foo",
            lastName: "Foo",
            userTag: "tt",
            department: .start,
            position: "po",
            birthday: "1999-02-01",
            phone: "430-738-7821"
        )
        
        // When
        presenter.deleteItemFromRealm(indexPath: mockIndexPath)
        
        // Then
        XCTAssertFalse(presenter.checkIsFavorite(item: person))
    }
}
