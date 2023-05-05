//
//  AdvertRequest.swift
//  ArabamCaseApp
//
//  Created by Yusuf Can Bircan on 5.05.2023.
//

import Foundation

enum AdvertRequest {
    case listing(sort: Int, sortDirection: Int, take: Int)
    case detail(id: String)
}

extension AdvertRequest: APIRequest {
    var path: String {
        switch self {
        case .listing:
            return UrlPath.listing.rawValue
        case .detail:
            return UrlPath.detail.rawValue
        }
    }
    
    var queryItems: [String: Any?]? {
        switch self {
        case .listing(let sort, let sortDirection, let take):
            return ["sort": sort, "sortDirection": sortDirection, "take": take]
        case .detail(let id):
            return ["id": id as String]
        }
    }
}
