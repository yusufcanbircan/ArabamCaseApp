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
    func didSelectAdvert(_ advert: AdvertDetailResponse)
}

final class AdvertListingViewControllerViewModel: NSObject {
    
    public weak var delegate: AdvertListingViewControllerViewModelDelegate?
    
    public var isLoadingMore: Bool = false
    public var isTheEnd = false
    private var advertsCounter: Int = 0
    private var advertsTake: Int = 10
    private var sortType: Int = 2 //SortTypes: price = 0, date = 1, year = 2
    private var sortDirection: Int = 0 //ListSortDirections: ascending=0, descending=1
    public var isInitialValue: Bool = true
    
    public var cellViewModels: [AdvertListingTableViewCellViewModel] = []
    private var adverts: AdvertListing = [] {
        didSet {
            for advert in adverts {
                let viewModel = AdvertListingTableViewCellViewModel(
                    priceLabel: "\(Int.formatNumber(number: advert.price ?? 0)) TL",
                    locationLabel: "\(advert.location?.cityName ?? "")/\(advert.location?.townName ?? "")",
                    titleLabel:  advert.title ?? "",
                    advertImage: URL(string: .getPhotoUrl(url: advert.photo) ?? "")
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
        advertsCounter = advertsCounter + advertsTake
        print(advertsCounter)
        let request = AdvertRequest.listing(sort: sortType, sortDirection: sortDirection, take: advertsCounter)
        print(request)
        
        
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

extension AdvertListingViewControllerViewModel: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard !isLoadingMore,
              !cellViewModels.isEmpty
        else { return }
        
        Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false) { [weak self] t in
            let offset = scrollView.contentOffset.y
            let totalContentHeight = scrollView.contentSize.height
            let totalScrollViewFixedHeight = scrollView.frame.size.height
            
            if offset >= (totalContentHeight - totalScrollViewFixedHeight - 120) {
                self?.fetchListingAdverts()
            }
            t.invalidate()
        }
    }
}

extension String {
    static func getPhotoUrl(url:String?, resolution: String = "240x180") -> String? {
        let url = url?.replacingOccurrences(of: "{0}", with: resolution)
        return url
    }
}

extension Int {
    static func formatNumber(number: Int) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        var str = numberFormatter.string(from: NSNumber(value: number)) ?? "\(number)"
        str = str.replacingOccurrences(of: ",", with: ".")
        return str
    }
}

