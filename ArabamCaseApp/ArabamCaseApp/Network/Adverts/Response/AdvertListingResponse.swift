//
//  AdvertResponse.swift
//  ArabamCaseApp
//
//  Created by Yusuf Can Bircan on 5.05.2023.
//

import Foundation

// MARK: - AdvertListingElement
struct AdvertListingResponse: Codable {
    let id: Int?
    let title: String?
    let location: Location?
    let category: Category?
    let modelName: String?
    let price: Int?
    let priceFormatted: String?
    let date, dateFormatted, photo: String?
    let properties: [Property]?
}

// MARK: - Category
struct Category: Codable {
    let id: Int?
    let name: String?
}

// MARK: - Location
struct Location: Codable {
    let cityName, townName: String?
}

// MARK: - Property
struct Property: Codable {
    let name: String?
    let value: String?
}

typealias AdvertListing = [AdvertListingResponse]
