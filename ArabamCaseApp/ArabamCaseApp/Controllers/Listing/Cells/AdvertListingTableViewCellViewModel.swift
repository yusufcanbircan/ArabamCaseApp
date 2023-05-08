//
//  AdvertListingTableViewCellViewModel.swift
//  ArabamCaseApp
//
//  Created by Yusuf Can Bircan on 6.05.2023.
//

import Foundation

struct AdvertListingTableViewCellViewModel: Hashable, Equatable {
    
    public let priceLabel: String
    public let advertId: Int
    public let locationLabel: String
    public let titleLabel: String
    private let advertImage: URL?
    
    // MARK: - Init
    
    init(priceLabel: String, locationLabel: String, titleLabel: String, advertImage: URL?, advertId: Int) {
        self.priceLabel = priceLabel
        self.locationLabel = locationLabel
        self.titleLabel = titleLabel
        self.advertImage = advertImage
        self.advertId = advertId
    }
    
    // MARK: Public
    
    public func fetchImage(completion: @escaping (Result<Data,Error>) -> (Void)) {
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
