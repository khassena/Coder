//
//  SortPresenterTests.swift
//  CoderTests
//
//  Created by Amanzhan Zharkynuly on 19.02.2023.
//

import XCTest
@testable import Coder

class SortPresenterTests: XCTestCase {

    var view = MockSortView()
    var presenter: SortViewPresenterProtocol!
    var router: RouterProtocol!
    var sortVC: SortViewController!
    
    override func setUpWithError() throws {
        router = MockRouter()
        sortVC = SortViewController()
        presenter = SortPresenter(
            view: view,
            router: router,
            sortVC: sortVC
        )
    }

    override func tearDownWithError() throws {
        router = nil
        sortVC = nil
        presenter = nil
    }

    func testDidTapSortButton() {
        // Given
        let newButton: SortModel = .alphabet
        
        // When
        presenter.didTapSortButton(newButton)
        
        // Then
        XCTAssertEqual(newButton, view.catchButton)
    }
    

}
