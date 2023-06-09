//
//  AdvertDetailServiceProtocol.swift
//  ArabamCaseApp
//
//  Created by Yusuf Can Bircan on 5.05.2023.
//

import Foundation

protocol AdvertDetailServiceProtocol {
    func fetchListingObjects(request: APIRequest, completion: @escaping (Result<AdvertDetail, Error>) -> Void)
}

final class AdvertDetailService: APIClient, AdvertDetailServiceProtocol {
    func fetchListingObjects(request: APIRequest, completion: @escaping (Result<AdvertDetail, Error>) -> Void) {
        call(request: request, completion: completion)
    }
}
