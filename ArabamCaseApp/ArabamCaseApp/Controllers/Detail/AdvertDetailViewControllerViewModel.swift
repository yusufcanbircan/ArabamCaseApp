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
        enum `Type`: String {
            case km
            case color
            case year
            case gear
            case fuel
        }
        
        sections = [
            .photo(viewModels: advert.photos?.compactMap({
                return PhotoCollectionViewCellViewModel(imageUrl: URL(string: .getPhotoUrl(url: $0, resolution: .medium) ?? ""))
            })),
            .userInformation(viewModel:
                    .init(name: advert.userInfo?.nameSurname ?? .unknownCase,
                          city: .getCity(advert: advert),
                          price: .getPrice(advert: advert),
                          title: advert.title ?? "İlan")),
            .information(viewModels: [
                .init(type: .km, value: .getObject(advert: advert, name:`Type`.km.rawValue)),
                .init(type: .color, value: .getObject(advert: advert, name: `Type`.color.rawValue)),
                .init(type: .date, value: advert.dateFormatted ?? .unknownCase),
                .init(type: .fuel, value: .getObject(advert: advert, name: `Type`.fuel.rawValue)),
                .init(type: .gear, value: .getObject(advert: advert, name: `Type`.gear.rawValue)),
                .init(type: .model, value: advert.modelName ?? .unknownCase),
                .init(type: .owner, value: advert.userInfo?.nameSurname ?? .unknownCase),
                .init(type: .year, value: .getObject(advert: advert, name: `Type`.year.rawValue))
            ]),
            .summary(viewModels: .init(summary: .getSummary(advert: advert)))
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
            top: 0,
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
                heightDimension: .estimated(120)
            ),
            subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        
        return section
    }
    
}
