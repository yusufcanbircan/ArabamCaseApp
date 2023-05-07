//
//  APIClient.swift
//  ArabamCaseApp
//
//  Created by Yusuf Can Bircan on 4.05.2023.
//

import Foundation

enum NetworkError: Error {
    case failedToDecodeData
    case failedToGetData
}

protocol APIClientProtocol {
    func call<T: Codable>(request: APIRequest, type: T.Type, completion: @escaping (Result<T, Error>) -> Void )
}

class APIClient: APIClientProtocol {
    
    private let session = URLSession.shared
    
    func call<T: Codable>(
        request: APIRequest,
        type: T.Type,
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        
        var urlComponents = URLComponents()
        urlComponents.host = request.host
        urlComponents.scheme = request.scheme
        urlComponents.path = request.path
        urlComponents.queryItems = request.urlQueryItems
        
        //print(T.self)
        
        guard let url = urlComponents.url else { return }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue
        
        session.dataTask(with: urlRequest) { data, _, error in
            guard let data = data, error == nil else {
                completion(.failure(NetworkError.failedToGetData))
                return
            }
            
            
            
            do {
                let result = try JSONDecoder().decode(AdvertListing.self, from: data)
                //let result = try JSONDecoder().decode(type.self, from: data)
                completion(.success(result as! T))
            }
            catch {
                completion(.failure(NetworkError.failedToDecodeData))
            }
            
        }.resume()
    }
}
