//
//  MockView.swift
//  CoderTests
//
//  Created by Amanzhan Zharkynuly on 16.02.2023.
//

import UIKit
@testable import Coder

class MockStaffView: StaffViewProtocol {
    
    var invokedNetworkSuccess: Bool?
    var mockImage: (UIImage?, Void)?
    
    func networkSuccess() {
        self.invokedNetworkSuccess = true
    }
    
    func imageLoader(with image: UIImage, indexPath: IndexPath) {
        mockImage = (image, ())
    }
    
    func networkFailure(error: Error) {
        
    }
    
    func showBirthdaySelected(_ show: Bool) {
        
    }
    
}
