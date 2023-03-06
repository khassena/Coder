//
//  MockNetworkService.swift
//  CoderTests
//
//  Created by Amanzhan Zharkynuly on 16.02.2023.
//

import UIKit
@testable import Coder

class MockNetworkService: NetworkServiceProtocol {
    
    var staff: Staff!
    var url: URL!
    
    init() {}
    
    convenience init(staff: Staff?) {
        self.init()
        self.staff = staff
    }
    
    func fetchData(completion: @escaping (Result<Staff?, Error>) -> Void) {
        if let staff = staff {
            completion(.success(staff))
        } else {
            let error = NSError(domain: "", code: 0, userInfo: nil)
            completion(.failure(error))
        }
    }
    
    func fetchImage(with url: URL?, completion: @escaping (Result<UIImage, Error>) -> Void) {
        
        if url != nil {
            completion(.success(UIImage()))
        } else {
            let error = NSError(domain: "", code: 1, userInfo: nil)
            completion(.failure(error))
        }
    }
    
}
