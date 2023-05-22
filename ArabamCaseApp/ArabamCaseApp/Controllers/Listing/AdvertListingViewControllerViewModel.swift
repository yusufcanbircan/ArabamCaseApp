//
//  AdvertListingViewControllerViewModel.swift
//  ArabamCaseApp
//
//  Created by Yusuf Can Bircan on 6.05.2023.
//

import UIKit

protocol AdvertListingViewDataSourceProtocol {
    var numberOfSection: Int { get }
    func numberOfItemsInSection(section: Int) -> Int
}

protocol AdvertListingViewControllerViewModelDelegate: NSObject {
    func didLoadAdverts(isInitial: Bool)
}

final class AdvertListingViewControllerViewModel: NSObject {
    
    weak var delegate: AdvertListingViewControllerViewModelDelegate?
    
    private var adverts: AdvertListing = []
    
    private var advertsCounter: Int = 0
    private var advertsTake: Int = 10
    private var sortType: sortingType = .price
    private var sortDirection: sortingDirection = .ascending
    
    var isInitialValue: Bool = true
    var isLoadingMore: Bool = false
    
}

// MARK: - DataSource
extension AdvertListingViewControllerViewModel: AdvertListingViewDataSourceProtocol {
    var numberOfSection: Int {
        1
    }
    
    func numberOfItemsInSection(section: Int) -> Int {
        adverts.count
    }
    
    func didSelectRowAt(indexPath: Int) -> Int? {
        return adverts[indexPath].id
    }
    
    func getListingCellAdvert(for index: Int) -> AdvertListingResponse? {
        return adverts[index]
    }
}

// MARK: - Type&Direction Enums & Helper
extension AdvertListingViewControllerViewModel {
    func fetchListingAdverts() {
        guard !isLoadingMore else { return }
        isLoadingMore = true

        let request = AdvertRequest.listing(sort: sortType.rawValue, sortDirection: sortDirection.rawValue, take: advertsTake, skip: advertsCounter)
        
        advertsCounter = advertsCounter + advertsTake
        
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
    
    func changeSorting(type: Int, direction: Int) {
        sortType = sortingType.allValues[type]
        sortDirection = sortingDirection.allValues[direction]
        advertsCounter = 0
        adverts = []
        self.fetchListingAdverts()
    }
    
    enum sortingDirection: Int {
        case ascending = 0
        case descending = 1
        
        static let allValues = [ascending, descending]
        static let names = ["Artan", "Azalan"]
    }

    enum sortingType: Int, CaseIterable {
        case price = 0
        case date = 1
        case year = 2
        
        static let allValues = [price, date, year]
        static let names = ["Fiyata Göre", "Tarihe Göre", "Yıla Göre"]
    }
}
