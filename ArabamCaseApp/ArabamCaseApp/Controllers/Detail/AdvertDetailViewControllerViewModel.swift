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
    
    public var detailTitle: String {
        return advert.modelName ?? "ilan detayı"
    }
    
    enum SectionType{
        case photo(viewModels: [PhotoCollectionViewCellViewModel]?)
        case userInformation(viewModel: UserInfoCollectionViewCellViewModel)
        case information(viewModels: [InfoCollectionViewCellViewModel])
        case summary(viewModels: SummaryCollectionViewCellViewModel)
    }
    
    public var sections: [SectionType] = []
    
    // MARK: - Init
    
    init(advert: AdvertDetailResponse) {
        self.advert = advert
        setUpSections()
    }
    
    
    // MARK: - Private
    
    private func setUpSections() {
        sections = [
            .photo(viewModels: advert.photos?.compactMap({
                return PhotoCollectionViewCellViewModel(imageUrl: URL(string: .getPhotoUrl(url: $0, resolution: "800x600") ?? ""))
            })),
            .userInformation(viewModel:
                    .init(name: advert.userInfo?.nameSurname ?? "unknown",
                          city: "\(advert.location?.townName ?? "")/\(advert.location?.cityName ?? "")",
                          price: "\(Int.formatNumber(number: advert.price ?? 0)) TL",
                          title: advert.title ?? "İlan")),
            .information(viewModels: [
                .init(type: .km, value: .getObject(advert: advert, name: "km")),
                .init(type: .color, value: .getObject(advert: advert, name: "color")),
                .init(type: .date, value: advert.dateFormatted ?? "unknown"),
                .init(type: .fuel, value: .getObject(advert: advert, name: "fuel")),
                .init(type: .gear, value: .getObject(advert: advert, name: "gear")),
                .init(type: .model, value: advert.modelName ?? "unknown"),
                .init(type: .owner, value: advert.userInfo?.nameSurname ?? "unknown"),
                .init(type: .year, value: .getObject(advert: advert, name: "year"))
            ]),
            .summary(viewModels: .init(summary: advert.text ?? "no text"))
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
            bottom: 0,
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
    
    public func createUserInformationSectionLayout() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(1.0)
            )
        )
        
        item.contentInsets = NSDirectionalEdgeInsets(
            top: 5,
            leading: 0,
            bottom: 5,
            trailing: 0
        )
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .estimated(130)
            ),
            subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        
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
            top: 0,
            leading: 0,
            bottom: 0,
            trailing: 0
        )
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .absolute(40)
            ),
            subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        
        return section
    }
    
    public func createSummarySectionLayout() -> NSCollectionLayoutSection {
        
        let height = NSCollectionLayoutDimension.estimated(500)
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(1.0)
            )
        )
        
        item.contentInsets = NSDirectionalEdgeInsets(
            top: 5,
            leading: 0,
            bottom: 0,
            trailing: 0
        )
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: height
            ),
            subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        
        return section
    }
    
}



extension String {
    static func getObject(advert: AdvertDetailResponse, name: String) -> String {
        
        guard let properties = advert.properties else { return ""}
        
        return properties.first(where: { $0.name == name })?.value ?? "bilinmiyor"
    }
}
