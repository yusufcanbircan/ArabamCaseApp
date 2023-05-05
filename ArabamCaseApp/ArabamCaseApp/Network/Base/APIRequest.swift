//
//  APIRequest.swift
//  ArabamCaseApp
//
//  Created by Yusuf Can Bircan on 4.05.2023.
//

import Foundation

@frozen enum UrlPath: String {
    case detail = "/api/v1/detail"
    case listing = "/api/v1/listing"
}

struct APIConstants {
    static let baseUrl: String = "sandbox.arabamd.com"
}

protocol APIRequest {
    var scheme: String { get }
    var host: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var header: [String: String]? { get }
    var queryItems: [String: Any?]? { get }
    var urlQueryItems: [URLQueryItem]? { get }
}

extension APIRequest {
    var scheme: String {
        "https"
    }
    
    var host: String {
        APIConstants.baseUrl
    }
    
    var header: [String: String]? {
        nil
    }
    
    var method: HTTPMethod {
        HTTPMethod.get
    }
    
    var path: String {
        UrlPath.listing.rawValue
    }
    
    var queryItems: [String: Any?]? {
        nil
    }
    
    var urlQueryItems: [URLQueryItem]? {
        Self.convertToURLQueryItems(items: queryItems)
    }
    
}

extension APIRequest {
    private static func convertToURLQueryItems(items: [String: Any?]?) -> [URLQueryItem]? {
        guard let items else { return nil }
        
        return items
            .filter { $0.value != nil }
            .flatMap { Self.buildQueryItems(key: $0.key, value: $0.value)}
    }
    
    private static func buildQueryItems(key: String, value: Any?) -> [URLQueryItem] {
        guard let value else {
            return [URLQueryItem(name: key, value: nil)]
        }

        switch value {
        case is String:
            return [URLQueryItem(name: key, value: value as? String)]
            
        case is Int,
            is Int32,
            is Bool,
            is Double,
            is Float:
            return [URLQueryItem(name: key, value: String(describing: value))]
            
        case let value as [Any]:
            return value
                .filter { false == ($0 is [Any]) }
                .flatMap { Self.buildQueryItems(key: key, value: $0) }
            
        default:
            return []
        }
    }
}
