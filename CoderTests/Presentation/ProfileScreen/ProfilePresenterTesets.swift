//
//  ProfilePresenterTesets.swift
//  CoderTests
//
//  Created by Amanzhan Zharkynuly on 19.02.2023.
//

import XCTest
import RealmSwift
@testable import Coder

class ProfilePresenterTesets: XCTestCase {
    
    var view = MockProfileView()
    var presenter: ProfileViewPresenterProtocol!
    var networkService: NetworkServiceProtocol!
    var router: RouterProtocol!
    
    override func setUpWithError() throws {
        router = MockRouter()
        networkService = MockNetworkService()
        presenter = ProfilePresenter(
            view: view,
            networkService: networkService,
            router: router
        )
        var uniqueConfiguration = Realm.Configuration.defaultConfiguration
        uniqueConfiguration.inMemoryIdentifier = NSUUID().uuidString
        Realm.Configuration.defaultConfiguration = uniqueConfiguration
        
        let realm = try! Realm()
        presenter.realm = realm
    }

    override func tearDownWithError() throws {
        networkService = nil
        presenter = nil
        router = nil
    }
    
    func testConfigureDataMethod() {
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
        presenter.item = person
        presenter.configureData()
        
        // Then
        XCTAssertEqual(person, view.catchPerson)
    }
    
    func testAddDataToRealmDatabase() {
        // Given
        let person = Person(
            id: "0",
            avatarUrl: "http://",
            firstName: "Foo",
            lastName: "Foo",
            userTag: "tt",
            department: .start,
            position: "po",
            birthday: "1",
            phone: "77"
        )
        
        // When
        presenter.item = person
        presenter.addToRealm()
        
        // Then
        XCTAssertTrue(presenter.checkIsFavorite())
    }
    
    func testDeleteDataFromRealmDatabase() {
        // Given
        let person = Person(
            id: "0",
            avatarUrl: "http://",
            firstName: "Foo",
            lastName: "Foo",
            userTag: "tt",
            department: .start,
            position: "po",
            birthday: "1",
            phone: "77"
        )
        
        // When
        presenter.item = person
        presenter.deleteFromRealm()
        
        // Then
        XCTAssertFalse(presenter.checkIsFavorite())
    }
}
