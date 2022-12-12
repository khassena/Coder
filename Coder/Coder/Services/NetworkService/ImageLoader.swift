//
//  ImageLoader.swift
//  Coder
//
//  Created by Amanzhan Zharkynuly on 09.12.2022.
//

import Foundation
import UIKit

class ImageLoader {
    
    private let imageCache = NSCache<AnyObject, AnyObject>()
    
    func fetchImage(with url: URL, completion: @escaping (Result<UIImage, Error>) -> Void) {
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
