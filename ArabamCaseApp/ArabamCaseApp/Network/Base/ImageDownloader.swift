//
//  ImageDownloader.swift
//  ArabamCaseApp
//
//  Created by Yusuf Can Bircan on 6.05.2023.
//

import Foundation

final class ImageDownloader {
    static let shared = ImageDownloader()
    
    private let imageDataCache = NSCache<NSString, NSData>()
    
    private init() {}
    
    public func downloadImage(url: URL, completion: @escaping (Result<Data, Error>) -> ()) {
        let key = url.absoluteString as NSString
        if let data = imageDataCache.object(forKey: key) {
            completion(.success(data as Data))
        }
        
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { [weak self] data, _, error in
            guard let data = data, error == nil, let self = self
            else {
                completion(.failure(URLError(.badServerResponse)))
                return
            }
            
            let value = data as NSData
            self.imageDataCache.setObject(value, forKey: key)
            completion(.success(data))
            
        }.resume()
    }
}
