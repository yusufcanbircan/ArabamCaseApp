//
//  AdvertDetailViewControllerViewModel.swift
//  ArabamCaseApp
//
//  Created by Yusuf Can Bircan on 8.05.2023.
//

import UIKit

protocol AdvertDetailViewDataSourceProtocol {
    var numberOfSection: Int { get }
    func numberOfItemsInSection(section: Int) -> Int
}

final class AdvertDetailViewControllerViewModel {
    let advert: AdvertDetailResponse?
    
    private var sections: [SectionType] = []
    
    // MARK: - Init
    init(advert: AdvertDetailResponse) {
        self.advert = advert
        didInit()
    }
    
    private func didInit() {
        configureSections(hasSummary: hasSummary())
    }
}

// MARK: - CollectionView Helper
extension AdvertDetailViewControllerViewModel: AdvertDetailViewDataSourceProtocol {
    var numberOfSection: Int { return sections.count }
    
    func numberOfItemsInSection(section: Int) -> Int {
        switch sectionAt(section: section) {
        case .photo:
            guard let advert, let photos = advert.photos else { return 0 }
            return photos.count
        case .userInformation:
            return 1
        case .information:
            guard let advert, let properties = advert.properties else { return 0 }
            return properties.count
        case .summary:
            return hasSummary() ? 1 : 0
        }
    }
    
    func sectionAt(section: Int) -> SectionType {
//        guard let sectionAt = sections[safe: section] else { return .none }
        return sections[section]
    }
    
    private func hasSummary() -> Bool {
        guard let advert, let text = advert.text, !text.isEmpty else { return false }
        return true
    }
    
    private func configureSections(hasSummary: Bool) {
        sections = hasSummary ? [.photo, .userInformation, .information, .summary] : [.photo, .userInformation, .information]
    }
}

// MARK: - CollectionView Datasource
extension AdvertDetailViewControllerViewModel {
    func getAdvertDetailPhoto(for index: Int) -> URL? {
        guard let advert, let photos = advert.photos, let urlString = photos[index].getPhotoUrl(resolution: .medium),
              let url = URL(string: urlString) else { return nil }
        return url
    }
    
    func getAdvertDetailUserInfo() -> AdvertDetailResponse? {
        guard let advert else { return nil }
        return advert
    }
    
    func getAdvertProperty(for index: Int) -> Property? {
        guard let advert, let property = advert.properties else { return nil }
        return property[index]
    }
    
    func getAdvertSummary() -> String? {
        guard let advert, let summary = advert.text else { return nil}
        return summary.getSummary()
    }
    
    // MARK - FullScreenDatasource
    func getFullScreenPhotos() -> [String]? {
        guard let advert else { return nil }
        return advert.photos
    }
    
    // MARK: - Title
    func getDetailTitle() -> String {
        guard let advert, let title = advert.modelName else { return "ilan detayı" }
        return title
    }
}

// MARK: - SectionType Enum
extension AdvertDetailViewControllerViewModel {
    enum SectionType: CaseIterable {
        case photo, userInformation, information, summary
        
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
                heightDimension: .estimated(130)
            )
        )
        
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
                heightDimension: .estimated(150)
            )
        )
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .estimated(150)
            ), subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        
        return section
    }
}
