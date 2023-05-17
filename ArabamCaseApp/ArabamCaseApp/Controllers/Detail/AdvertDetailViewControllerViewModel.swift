//
//  AdvertDetailViewControllerViewModel.swift
//  ArabamCaseApp
//
//  Created by Yusuf Can Bircan on 8.05.2023.
//

import UIKit

protocol AdvertDetailViewDataSourceProtocol {
    var numberOfSection: Int { get }
}

final class AdvertDetailViewControllerViewModel{
    let advert: AdvertDetailResponse?
    
    private var sections: [SectionType] = []
    
    public var detailTitle: String {
        return advert?.modelName ?? "ilan detayı"
    }
    
    // MARK: - Init
    init(advert: AdvertDetailResponse) {
        self.advert = advert
        didInit()
    }
    
    private func didInit() {
        configureSections(hasSummary: hasSummary())
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
    }
}

// MARK: - CollectionView Helper
extension AdvertDetailViewControllerViewModel: AdvertDetailViewDataSourceProtocol {
    var numberOfSection: Int { return sections.count }
    
    func numberOfItemsInSection(section: Int) -> Int {
        switch sectionAt(section: section) {
        case .photo:
            return advert?.photos?.count ?? 0
        case .userInformation:
            return 1
        case .information:
            return 0
        case .summary:
            return 0
        case .none:
            return 0
        }
    }
    
    func sectionAt(section: Int) -> SectionType {
//        guard let sectionAt = sections[safe: section] else { return .none }
        return sections[section]
    }
    
    private func hasSummary() -> Bool{
        return advert?.text != nil
    }
    
    private func configureSections(hasSummary: Bool) {
        sections = hasSummary ? [.photo, .userInformation, .information, .summary] : [.photo, .userInformation, .information]
    }
    
    // MARK - FullScreenDatasource
    func getFullScreenPhotos() -> [String]? {
        return advert?.photos
    }
}

// MARK: - CollectionView Datasource
extension AdvertDetailViewControllerViewModel {
    func getAdvertDetailPhoto(for index: Int) -> URL? {
        guard let photos = advert?.photos, let urlString = photos[index].getPhotoUrl(resolution: .medium),
              let url = URL(string: urlString) else { return nil }
        return url
    }
    
    func getAdvertDetailUserInfo() -> AdvertDetailResponse? {
        guard let advert else { return nil}
        return advert
    }
    
    
}

// MARK: - SectionType Enum
extension AdvertDetailViewControllerViewModel {
    enum SectionType: CaseIterable {
        case photo, userInformation, information, summary, none
        
        var cellClass: UICollectionViewCell.Type {
            switch self {
            case .photo:
                return PhotoCollectionViewCell.self
            case .userInformation:
                return UserInfoCollectionViewCell.self
            case .information:
                return InfoCollectionViewCell.self
            case .summary:
                return SummaryCollectionViewCell.self
            case .none:
                return UICollectionViewCell.self
            }
        }
    }
}

// MARK: - CollectionViewLayout Helper
extension AdvertDetailViewControllerViewModel {
    func createPhotoSectionLayout() -> NSCollectionLayoutSection {
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
    
    func createUserInformationSectionLayout() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(1.0)
            )
        )
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 5, trailing: 0)
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .estimated(130)
            ), subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        
        return section
    }
    
    func createInformationSectionLayout() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(1.0)
            )
        )
        
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .absolute(40)
            ), subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        
        return section
    }
    
    func createSummarySectionLayout() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(1.0)
            )
        )
        
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 0, bottom: 0, trailing: 0)
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .estimated(120)
            ), subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        
        return section
    }
}
