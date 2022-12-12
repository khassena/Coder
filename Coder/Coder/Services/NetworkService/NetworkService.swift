//
//  NetworkService.swift
//  Coder
//
//  Created by Amanzhan Zharkynuly on 30.11.2022.
//

import Foundation

protocol NetworkServiceProtocol {
    func fetchData(completion: @escaping (Result<Staff?, Error>) -> Void)
}

class NetworkService: NetworkServiceProtocol {
    
    
    func fetchData(completion: @escaping (Result<Staff?, Error>) -> Void) {
        
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
}
