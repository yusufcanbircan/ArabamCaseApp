//
//  UserInfoCollectionViewCellViewModel.swift
//  ArabamCaseApp
//
//  Created by Yusuf Can Bircan on 10.05.2023.
//

import Foundation

final class UserInfoCollectionViewCellViewModel {
    private let advert: AdvertDetailResponse
    
    var name: String {
        return getName(advert: advert)
    }
    
    var city: String {
        return getCity(advert: advert)
    }
    
    var price: String {
        return getPrice(advert: advert)
    }
    
    var title: String {
        return getTitle(advert: advert)
    }
    
    init(advert: AdvertDetailResponse) {
        self.advert = advert
    }
}

// MARK: - Helper
extension UserInfoCollectionViewCellViewModel {
    private func getName(advert: AdvertDetailResponse) -> String {
        guard let name = advert.userInfo?.nameSurname else { return "-"}
        return name
    }
    
    private func getCity(advert: AdvertDetailResponse) -> String {
        guard let city = advert.location?.cityName, let town = advert.location?.townName else { return "-"}
        return "\(city)/\(town)"
    }
    
    private func getPrice(advert: AdvertDetailResponse) -> String {
        guard let price = advert.price?.formatNumber() else { return "0 TL"}
        return "\(price) TL"
    }
    
    private func getTitle(advert: AdvertDetailResponse) -> String {
        guard let title = advert.title else { return "-"}
        return title
    }
}

