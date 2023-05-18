//
//  UserInfoCollectionViewCellViewModel.swift
//  ArabamCaseApp
//
//  Created by Yusuf Can Bircan on 10.05.2023.
//

import Foundation

final class UserInfoCollectionViewCellViewModel {
    private let advert: AdvertDetailResponse
    
    var name: String { getName(advert: advert) }
    var city: String { getCity(advert: advert) }
    var price: String { getPrice(advert: advert) }
    var title: String { getTitle(advert: advert) }
    
    init(advert: AdvertDetailResponse) {
        self.advert = advert
    }
}

// MARK: - Helper
extension UserInfoCollectionViewCellViewModel {
    private func getName(advert: AdvertDetailResponse) -> String {
        guard let userInfo = advert.userInfo, let name = userInfo.nameSurname else { return "-"}
        return name
    }
    
    private func getCity(advert: AdvertDetailResponse) -> String {
        guard let location = advert.location, let city = location.cityName, let town = location.townName else { return "-" }
        return "\(city)/\(town)"
    }
    
    private func getPrice(advert: AdvertDetailResponse) -> String {
        guard let price = advert.price else { return "0 TL" }
        return "\(price.formatNumber()) TL"
    }
    
    private func getTitle(advert: AdvertDetailResponse) -> String {
        guard let title = advert.title else { return "-"}
        return title
    }
}

