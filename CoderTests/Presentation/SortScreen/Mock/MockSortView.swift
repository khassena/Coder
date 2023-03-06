//
//  MockSortView.swift
//  CoderTests
//
//  Created by Amanzhan Zharkynuly on 19.02.2023.
//

import UIKit
@testable import Coder

class MockSortView: NSObject, SortViewProtocol {
    
    var sortVC: SortViewController?
    var catchButton: SortModel?
    
    func sortBy(_ button: SortModel) {
        catchButton = button
    }
    
    
    
    
}
