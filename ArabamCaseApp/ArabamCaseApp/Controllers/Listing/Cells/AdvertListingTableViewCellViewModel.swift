//
//  AdvertListingTableViewCellViewModel.swift
//  ArabamCaseApp
//
//  Created by Yusuf Can Bircan on 6.05.2023.
//

import Foundation

struct AdvertListingTableViewCellViewModel: Hashable, Equatable {

    private var advertResponse: AdvertListingResponse
    
    var priceLabel: String { getPrice(advert: advertResponse) }
    var advertId: Int { getId(advert: advertResponse) }
    var locationLabel: String { getCity(advert: advertResponse) }
    var titleLabel: String { getTitle(advert: advertResponse) }
    var advertImage: URL? { getImageUrl(advert: advertResponse) }
    
    // MARK: - Init
    init(advertResponse: AdvertListingResponse) {
        self.advertResponse = advertResponse
    }
    
    func fetchImage(completion: @escaping (Result<Data,Error>) -> (Void)) {
        guard let url = advertImage else {
            completion(.failure(URLError(.badURL)))
            return
        }
        
        ImageDownloader.shared.downloadImage(url: url, completion: completion)
    }
    
    // MARK: - Hash
    static func == (lhs: AdvertListingTableViewCellViewModel, rhs: AdvertListingTableViewCellViewModel) -> Bool {
        lhs.hashValue == rhs.hashValue
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(priceLabel)
        hasher.combine(locationLabel)
        hasher.combine(titleLabel)
        hasher.combine(advertImage)
        hasher.combine(advertId)
    }
}

// MARK: - Helper
extension AdvertListingTableViewCellViewModel {
    private func getImageUrl(advert: AdvertListingResponse) -> URL? {
        guard let photo = advert.photo, let urlString = photo.getPhotoUrl(resolution: .low), let url = URL(string: urlString) else { return nil }
        return url
    }
    
    private func getId(advert: AdvertListingResponse) -> Int {
        guard let id = advert.id else { return 0 }
        return id
    }
    
    private func getCity(advert: AdvertListingResponse) -> String {
        guard let location = advert.location, let city = location.cityName, let town = location.townName else { return "-" }
        return "\(city)/\(town)"
    }
    
    private func getPrice(advert: AdvertListingResponse) -> String {
        guard let price = advert.price else { return "0 TL" }
        return "\(price.formatNumber()) TL"
    }
    
    private func getTitle(advert: AdvertListingResponse) -> String {
        guard let title = advert.title else { return "-"}
        return title
    }
}
