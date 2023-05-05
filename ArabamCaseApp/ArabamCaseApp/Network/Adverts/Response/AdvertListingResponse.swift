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
    let date: DateEnum?
    let dateFormatted: DateFormatted?
    let photo: String?
    let properties: [Property]?
}

// MARK: - Category
struct Category: Codable {
    let id: Int?
    let name: String?
}

enum DateEnum: String, Codable {
    case the20201111T000000 = "2020-11-11T00:00:00"
    case the20201112T000000 = "2020-11-12T00:00:00"
}

enum DateFormatted: String, Codable {
    case the11Kasım2020 = "11 Kasım 2020"
    case the12Kasım2020 = "12 Kasım 2020"
}

// MARK: - Location
struct Location: Codable {
    let cityName, townName: String?
}

// MARK: - Property
struct Property: Codable {
    let name: Name?
    let value: String?
}

enum Name: String, Codable {
    case color = "color"
    case km = "km"
    case year = "year"
}

typealias AdvertListing = [AdvertListingResponse]
