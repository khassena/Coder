//
//  StaffPresenterTests.swift
//  CoderTests
//
//  Created by Amanzhan Zharkynuly on 16.02.2023.
//

import XCTest
import RealmSwift
import Realm
@testable import Coder

class StaffPresenterTests: XCTestCase {
    
    var view: StaffViewProtocol!
    var presenter: StaffViewPresenterProtocol!
    var networkService: NetworkServiceProtocol!
    var router: RouterProtocol!
    var items = [Person]()
    lazy var staff = Staff(items: items)
    
    override func setUpWithError() throws {
        view = MockStaffView()
        networkService = MockNetworkService()
        router = MockRouter()
        presenter = StaffPresenter(
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
        view = nil
        presenter = nil
        networkService = nil
    }

    func testGetSuccessStaffData() {
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
        items.append(person)
        staff.items = items

        networkService = MockNetworkService(staff: staff)
        
        var catchData: Staff?
        
        networkService.fetchData { result in
            switch result {
            case .success(let staff):
                catchData = staff
            case .failure(let error):
                print(error)
            }
        }

        // Then
        XCTAssertNotNil(catchData)
    }
    
    func testGetSuccessStaffAvatarImage() {
        // Given
        let urlString = "http://123.jpg"
        guard let url = URL(string: urlString) else { return }
        
        // When
        var catchImage: UIImage?
        
        networkService.fetchImage(with: url) { result in
            switch result {
            case .success(let image):
                catchImage = image
            case .failure(let error):
                print(error)
            }
        }

        // Then
        XCTAssertNotEqual(catchImage, nil)
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
        presenter.addToRealm(item: person)
        
        // Then
        XCTAssertTrue(presenter.checkIsFavorite(item: person))
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
        presenter.deleteItemFromRealm(item: person)
        
        // Then
        XCTAssertFalse(presenter.checkIsFavorite(item: person))
    }
    
    func testFilterTableViewBySearching() {
        // Given
        let firstPerson = Person(
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
        let secondPerson = Person(
            id: "1",
            avatarUrl: "http://",
            firstName: "Boo",
            lastName: "Boo",
            userTag: "tt",
            department: .start,
            position: "po",
            birthday: "1",
            phone: "77"
        )
        staff.items = [firstPerson, secondPerson]
        
        // When
        presenter.staff = staff
        presenter.filterTableView(searchText: "Boo", sort: nil)
        
        // Then
        XCTAssertEqual(secondPerson, presenter.items?.first)
    }
    
    func testFilterTableViewBySortingAlphabet() {
        // Given
        let firstPerson = Person(
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
        let secondPerson = Person(
            id: "1",
            avatarUrl: "http://",
            firstName: "Boo",
            lastName: "Boo",
            userTag: "tt",
            department: .start,
            position: "po",
            birthday: "1",
            phone: "77"
        )
        staff.items = [firstPerson, secondPerson]
        
        // When
        presenter.staff = staff
        presenter.filterTableView(searchText: nil, sort: .alphabet)
        
        // Then
        XCTAssertEqual(secondPerson, presenter.items?.first)
    }
    
    func testFilterTableViewBySortingBirthday() {
        // Given
        let firstPerson = Person(
            id: "0",
            avatarUrl: "http://",
            firstName: "Foo",
            lastName: "Foo",
            userTag: "tt",
            department: .start,
            position: "po",
            birthday: "2000-03-01",
            phone: "77"
        )
        let secondPerson = Person(
            id: "1",
            avatarUrl: "http://",
            firstName: "Boo",
            lastName: "Boo",
            userTag: "tt",
            department: .start,
            position: "po",
            birthday: "1999-02-01",
            phone: "77"
        )
        
        let thirdPerson = Person(
            id: "2",
            avatarUrl: "http://",
            firstName: "Hoo",
            lastName: "hoo",
            userTag: "tt",
            department: .start,
            position: "po",
            birthday: "1998-01-01",
            phone: "77"
        )
        staff.items = [firstPerson, secondPerson, thirdPerson]
        
        // When
        presenter.staff = staff
        presenter.filterTableView(searchText: nil, sort: .birthday)
        
        // Then
        XCTAssertEqual(thirdPerson, presenter.itemsForSection?.first)
    }
    
    
}
