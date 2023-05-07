//
//  AdvertListingService.swift
//  ArabamCaseApp
//
//  Created by Yusuf Can Bircan on 5.05.2023.
//

import Foundation

protocol AdvertListingServiceProtocol {
    func fetchListingObjects(request: APIRequest, completion: @escaping (Result<[AdvertListingResponse], Error>) -> Void)
}

final class AdvertListingService: APIClient, AdvertListingServiceProtocol {
    func fetchListingObjects(request: APIRequest, completion: @escaping (Result<[AdvertListingResponse], Error>) -> Void) {
        call(request: request, type: [AdvertListingResponse].self, completion: completion)
    }
}
