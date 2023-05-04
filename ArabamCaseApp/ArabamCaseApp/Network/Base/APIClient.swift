//
//  APIClient.swift
//  ArabamCaseApp
//
//  Created by Yusuf Can Bircan on 4.05.2023.
//

import Foundation

enum NetworkError: Error {
    case failedToCreateRequest
    case failedToGetData
}

protocol APIClientProtocol {
    func call<T: Decodable>(request: APIRequest, type: T.Type, completion: @escaping (Result<T, Error>) -> Void )
}

class APIClient: APIClientProtocol {
    
    private let session = URLSession.shared
    
    func call<T: Decodable>(
        request: APIRequest,
        type: T.Type,
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        var urlComponents = URLComponents(string: request.baseURL)
        urlComponents?.path = request.path.rawValue
        urlComponents?.queryItems = request.urlQueryItems
        
        guard let url = urlComponents?.url else { return }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue
        
        session.dataTask(with: urlRequest) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                completion(.failure(NetworkError.failedToGetData))
                return
            }
            
            do {
                let result = try JSONDecoder().decode(type.self, from: data)
                completion(.success(result))
            }
            catch {
                completion(.failure(error))
            }
            
        }.resume()
    }
}
