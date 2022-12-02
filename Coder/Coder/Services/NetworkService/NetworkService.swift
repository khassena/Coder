//
//  NetworkService.swift
//  Coder
//
//  Created by Amanzhan Zharkynuly on 30.11.2022.
//

import Foundation

class NetworkService {
    
    
    func fetchData(completion: @escaping (Result<Staff?, Error>) -> Void) {
        
        guard let url = URL(string: Constants.baseUrl) else { return }
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = Constants.headers
        
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            let data = data
            do {
                let result = try JSONDecoder().decode(Staff.self, from: data!)
                completion(.success(result))
            } catch {
                completion(.failure(error))
            }
            
        }
        task.resume()
    }
}
