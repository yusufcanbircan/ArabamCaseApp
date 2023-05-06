//
//  AdvertListingViewControllerViewModel.swift
//  ArabamCaseApp
//
//  Created by Yusuf Can Bircan on 6.05.2023.
//

import Foundation

protocol AdvertListingViewControllerViewModelDelegate: NSObject {
    func didLoadAdverts(isInitial: Bool)
    func didSelectAdvert(_ advert: AdvertDetailResponse)
}

final class AdvertListingViewControllerViewModel: NSObject {
    
    public weak var delegate: AdvertListingViewControllerViewModelDelegate?
    
    private var isLoadingMore: Bool = false
    private var advertsCount: Int = 10
    
    public var cellViewModels: [AdvertListingTableViewCellViewModel] = []
    private var adverts: AdvertListing = [] {
        didSet {
            for advert in adverts {
                let viewModel = AdvertListingTableViewCellViewModel(
                    priceLabel: "\(advert.price ?? 0) TL",
                    locationLabel: "\(advert.location?.cityName ?? "")/\(advert.location?.townName ?? "")",
                    titleLabel: advert.title ?? "",
                    advertImage: URL(string: advert.photo ?? "")
                )
                cellViewModels.append(viewModel)
            
//                if !cellViewModels.contains(viewModel) {
//                    cellViewModels.append(viewModel)
//                }
                
            }
        }
    }
    
}
