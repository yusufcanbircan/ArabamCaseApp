//
//  AdvertDetailViewControllerViewModel.swift
//  ArabamCaseApp
//
//  Created by Yusuf Can Bircan on 8.05.2023.
//

import UIKit

final class AdvertDetailViewControllerViewModel {
    private let advert: AdvertDetailResponse
    
    public var photos: [String] {
        guard let photos = advert.photos else { return [] }
        return photos
    }
    
    enum SectionType{
        case photo(viewModels: [PhotoCollectionViewCellViewModel]?)
        case information(viewModels: [InfoCollectionViewCellViewModel])
    }
    
    public var sections: [SectionType] = []
    
    // MARK: - Init
    
    init(advert: AdvertDetailResponse) {
        self.advert = advert
        setUpSections()
    }
    
    private func setUpSections() {
        sections = [
            .photo(viewModels: advert.photos?.compactMap({
                return PhotoCollectionViewCellViewModel(imageUrl: URL(string: .getPhotoUrl(url: $0, resolution: "800x600") ?? ""))
            })),
            .information(viewModels: [
                .init(type: .km, value: .getObject(advert: advert, name: "km")),
                .init(type: .color, value: .getObject(advert: advert, name: "color")),
                .init(type: .date, value: advert.dateFormatted ?? "unknown"),
                .init(type: .fuel, value: .getObject(advert: advert, name: "fuel")),
                .init(type: .gear, value: .getObject(advert: advert, name: "gear")),
                .init(type: .model, value: advert.modelName ?? "unknown"),
                .init(type: .owner, value: advert.userInfo?.nameSurname ?? "unknown"),
                .init(type: .year, value: .getObject(advert: advert, name: "year"))
                      
            ])
        ]
        
    }
    
    // MARK: - Layout
    public func createPhotoSectionLayout() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(1.0)
            )
        )
        
        item.contentInsets = NSDirectionalEdgeInsets(
            top: 0,
            leading: 0,
            bottom: 10,
            trailing: 0
        )
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalWidth(0.66)
            ),
            subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        
        return section
    }
    
    public func createInformationSectionLayout() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(1.0)
            )
        )
        
        item.contentInsets = NSDirectionalEdgeInsets(
            top: 2,
            leading: 2,
            bottom: 2,
            trailing: 2
        )
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .absolute(50)
            ),
            subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        
        return section
    }
}



extension String {
    static func getObject(advert: AdvertDetailResponse, name: String) -> String {
        
        return ""
    }
}
