//
//  AdvertDetailResponse.swift
//  ArabamCaseApp
//
//  Created by Yusuf Can Bircan on 5.05.2023.
//

import Foundation

// MARK: - AdvertDetail
struct AdvertDetailResponse: Decodable {
    let id: Int?
    let title: String?
    let location: Location?
    let category: Category?
    let modelName: String?
    let price: Int?
    let date: String?
    let priceFormatted, dateFormatted: String?
    let photos: [String]?
    let properties: [Property]?
    let text: String?
    let userInfo: UserInfo?
}

// MARK: - UserInfo
struct UserInfo: Decodable {
    let id: Int?
    let nameSurname, phone, phoneFormatted: String?
}

typealias AdvertDetail = AdvertDetailResponse
