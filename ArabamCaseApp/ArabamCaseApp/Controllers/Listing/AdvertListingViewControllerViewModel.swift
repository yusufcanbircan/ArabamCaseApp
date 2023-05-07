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
    private var advertsTake: Int = 10
    private var sortType: Int = 0 //SortTypes: price = 0, date = 1, year = 2
    private var sortDirection: Int = 0 //ListSortDirections: ascending=0, descending=1
    
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
                
                if !cellViewModels.contains(viewModel) {
                    cellViewModels.append(viewModel)
                }
                
            }
        }
    }
    
    // MARK: - Public
    
    public func fetchListingAdverts() {
        guard !isLoadingMore else { return }
        
        isLoadingMore = true
        let request = AdvertRequest.listing(sort: sortType, sortDirection: sortDirection, take: advertsTake)
//        guard let request = AdvertRequest.listing(sort: sortType, sortDirection: sortDirection, take: advertsTake) else {
//            isLoadingMore = false
//            return
//        }
//
        APIClient().call(request: request, type: AdvertListing.self) { result in
            switch result {
            case .success(let responseModal):
                print(responseModal.count)
            case .failure(let failure):
                print(failure)
            }
            self.isLoadingMore = false
        }
        
//        AdvertListingService().fetchListingObjects(request: request) { result in
//            switch result {
//            case .success(let responseModal):
//                print(responseModal.count)
//            case .failure(let failure):
//                print(failure)
//            }
//            self.isLoadingMore = false
//        }
//        RMService.shared.execute(request,
//                                 expecting: RMGetAllCharactersResponse.self) { [weak self] result in
//            guard let self = self else { return }
//            switch result {
//            case .success(let responseModel):
//                let moreResults = responseModel.results
//                let info = responseModel.info
//                self.apiInfo = info
//
//                let originalCount = self.characters.count
//                let newCount = moreResults.count
//                let total = newCount + originalCount
//                let startingIndex = total - newCount
//                let indexPathsToAdd: [IndexPath] = Array(startingIndex..<(startingIndex+newCount)).compactMap({
//                    return IndexPath(row: $0, section: 0)
//                })
//
//                self.characters.append(contentsOf: moreResults)
//                DispatchQueue.main.async {
//                    self.delegate?.didLoadMoreCharacters(
//                        with: indexPathsToAdd
//                    )
//                    self.isLoadingMoreCharacter = false
//                }
//            case .failure(let failure):
//                print(String(describing: failure))
//                self.isLoadingMoreCharacter = false
//            }
//        }
        
    }
    
}
