//
//  MockFavoriteView.swift
//  CoderTests
//
//  Created by Amanzhan Zharkynuly on 06.03.2023.
//

import UIKit
@testable import Coder

class MockFavoriteView: FavoriteViewProtocol {
    
    func imageLoader(with image: UIImage, indexPath: IndexPath) {
        
    }
    
    func networkFailure(error: Error) {
        
    }
}
