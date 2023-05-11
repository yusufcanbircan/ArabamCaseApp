//
//  AdvertListingViewControllerViewModel.swift
//  ArabamCaseApp
//
//  Created by Yusuf Can Bircan on 6.05.2023.
//

import Foundation
import UIKit

protocol AdvertListingViewControllerViewModelDelegate: NSObject {
    func didLoadAdverts(isInitial: Bool)
}

final class AdvertListingViewControllerViewModel: NSObject {
    
    public weak var delegate: AdvertListingViewControllerViewModelDelegate?
    
    private var advertsCounter: Int = 0
    private var advertsTake: Int = 10
    private var sortType: sortingType = .price
    private var sortDirection: sortingDirection = .ascending
    
    public var isInitialValue: Bool = true
    public var isLoadingMore: Bool = false
    public var isTheEnd = false
    public var sortingTypes = ["Fiyata Göre", "Tarihe Göre", "Yıla Göre"]
    public var sortingDirections = ["Artan", "Azalan"]
    
    public var cellViewModels: [AdvertListingTableViewCellViewModel] = []
    private var adverts: AdvertListing = [] {
        didSet {
            for advert in adverts {
                let viewModel: AdvertListingTableViewCellViewModel = Self.getCellViewModel(advert: advert)
                
                if !cellViewModels.contains(viewModel) { cellViewModels.append(viewModel) }
            }
        }
    }
    
    // MARK: - Private
    
    private static func getCellViewModel(advert: AdvertListingResponse) -> AdvertListingTableViewCellViewModel {
        AdvertListingTableViewCellViewModel(
            priceLabel: "\(Int.formatNumber(number: advert.price ?? 0)) TL",
            locationLabel: "\(advert.location?.cityName ?? "")/\(advert.location?.townName ?? "")",
            titleLabel:  advert.title ?? "",
            advertImage: URL(string: .getPhotoUrl(url: advert.photo) ?? ""),
            advertId: advert.id ?? 0
        )
    }
    
    // MARK: - Public
    
    public func changeSorting(type: Int, direction: Int) {
        sortType = sortingType.allValues[type]
        sortDirection = sortingDirection.allValues[direction]
        advertsCounter = 0
        adverts = []
        cellViewModels = []
        self.fetchListingAdverts()
    }
    
    public func fetchListingAdverts() {
        guard !isLoadingMore else { return }
        
        isLoadingMore = true
        advertsCounter = advertsCounter + advertsTake
        
        let request = AdvertRequest.listing(sort: sortType.rawValue, sortDirection: sortDirection.rawValue, take: advertsCounter)
        
        AdvertListingService().fetchListingObjects(request: request) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let responseModal):
                self.adverts.append(contentsOf: responseModal)
                DispatchQueue.main.async {
                    self.delegate?.didLoadAdverts(isInitial: self.isInitialValue)
                    self.isInitialValue = false
                    self.isLoadingMore = false
                }
                
            case .failure(let failure):
                print(failure)
                self.isLoadingMore = false
            }
        }
    }
}

enum sortingDirection: Int {
    case ascending = 0
    case descending = 1
    
    static let allValues = [ascending, descending]
}

enum sortingType: Int, CaseIterable {
    case price = 0
    case date = 1
    case year = 2
    
    static let allValues = [price, date, year]
}
