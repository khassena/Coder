//
//  NetworkService.swift
//  Coder
//
//  Created by Amanzhan Zharkynuly on 30.11.2022.
//

import Foundation
import UIKit

protocol NetworkServiceProtocol {
    func fetchData(completion: @escaping (Result<Staff?, Error>) -> Void)
    func fetchImage(with url: URL?, completion: @escaping (Result<UIImage, Error>) -> Void)
}

class NetworkService: NetworkServiceProtocol {
    
    // MARK: - Fetching Data
    
    func fetchData(completion: @escaping (Result<Staff?, Error>) -> Void) {
        imageCache.removeAllObjects()
        guard let url = URL(string: Constants.API.baseUrl) else { return }
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = Constants.API.headers
        
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            } else if let data = data {
                do {
                    let result = try JSONDecoder().decode(Staff.self, from: data)
                    completion(.success(result))
                } catch {
                    completion(.failure(error))
                }
            }
        }
        task.resume()
    }
    
    // MARK: - Load Image and Cache
    
    private let imageCache = NSCache<AnyObject, AnyObject>()
    
    func fetchImage(with url: URL?, completion: @escaping (Result<UIImage, Error>) -> Void) {
        guard let url = url else { return }
        if let imageFromCache = imageCache.object(forKey: url as AnyObject) as? UIImage {
            completion(.success(imageFromCache))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            } else if let data = data, let imageToCache = UIImage(data: data) {
                self.imageCache.setObject(imageToCache, forKey: url as AnyObject)
                completion(.success(imageToCache))
            }
        }
        task.resume()
    }
}
