//
//  AdvertDetailViewController.swift
//  ArabamCaseApp
//
//  Created by Yusuf Can Bircan on 8.05.2023.
//

import UIKit

final class AdvertDetailViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    private let viewModel: AdvertDetailViewControllerViewModel
    
    // MARK: - Init
    required init(viewModel: AdvertDetailViewControllerViewModel) {
        self.viewModel = viewModel
        super.init(nibName: String(describing: type(of: self)), bundle: Bundle(for: Self.self))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        didLoad()
    }
    
    private func didLoad() {
        title = viewModel.getDetailTitle()
        setUpCollectionView()
    }
}

// MARK: - CollectionView Helper
extension AdvertDetailViewController {
    private func setUpCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        registerCell()
        createCollectionViewLayout()
    }
    
    private func registerCell() {
        AdvertDetailViewControllerViewModel.SectionType.allCases.forEach { section in
            self.collectionView.register(nibWithCellClass: section.cellClass)
        }
    }
    
    private func createCollectionViewLayout() {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, _ in
            return self.createSection(for: sectionIndex)
        }
        collectionView.collectionViewLayout = layout
    }
    
    private func createSection(for sectionIndex: Int) -> NSCollectionLayoutSection {
        switch viewModel.sectionAt(section: sectionIndex) {
        case .photo:
            return viewModel.createPhotoSectionLayout()
        case .userInformation:
            return viewModel.createUserInformationSectionLayout()
        case .information:
            return viewModel.createInformationSectionLayout()
        case .summary:
            return viewModel.createSummarySectionLayout()
        }
    }
}

// MARK: - CollectionViewDelegate, CollectionViewDataSource
extension AdvertDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.numberOfSection
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItemsInSection(section: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch viewModel.sectionAt(section: indexPath.section) {
        case .photo:
            return configurePhotoCell(indexPath: indexPath)
        case .userInformation:
            return configureUserInfoCell(indexPath: indexPath)
        case .information:
            return configureInfoCell(indexPath: indexPath)
        case .summary:
            return configureSummaryCell(indexPath: indexPath)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch viewModel.sectionAt(section: indexPath.section) {
        case .photo:
            self.handleFullScreen(photos: viewModel.getFullScreenPhotos())
        default:
            break
        }
    }
}

// MARK: - CollectionView Helper
extension AdvertDetailViewController {
    private func configurePhotoCell(indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withClass: PhotoCollectionViewCell.self, for: indexPath)
        guard let url = viewModel.getAdvertDetailPhoto(for: indexPath.row) else { return UICollectionViewCell() }
        let cellModel = PhotoCollectionViewCellViewModel(imageUrl: url)
        cell.configure(viewModel: cellModel)
        return cell
    }
    
    private func configureUserInfoCell(indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withClass: UserInfoCollectionViewCell.self, for: indexPath)
        guard let advert = viewModel.getAdvertDetailUserInfo() else { return UICollectionViewCell() }
        let cellModel = UserInfoCollectionViewCellViewModel(advert: advert)
        cell.configure(viewModel: cellModel)
        return cell
    }
    
    private func configureInfoCell(indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withClass: InfoCollectionViewCell.self, for: indexPath)
        guard let property = viewModel.getAdvertProperty(for: indexPath.row) else { return UICollectionViewCell() }
        let cellModel = InfoCollectionViewCellViewModel(property: property)
        cell.configure(viewModel: cellModel)
        return cell
    }
    
    private func configureSummaryCell(indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withClass: SummaryCollectionViewCell.self, for: indexPath)
        cell.setNeedsLayout()
        cell.layoutIfNeeded()
        
        let size = cell.contentView.systemLayoutSizeFitting(CGSize(width: collectionView.bounds.width, height: UIView.layoutFittingCompressedSize.height))
        
        var cellFrame = cell.frame
        cellFrame.size.height = size.height
        cell.frame = cellFrame
        
        guard let summary = viewModel.getAdvertSummary() else { return UICollectionViewCell() }
        let cellModel = SummaryCollectionViewCellViewModel(summary: summary)
        cell.configure(viewModel: cellModel)
        return cell
    }
    
    private func handleFullScreen(photos: [String]?) {
        // handle push error
        let viewModel = FullScreenViewControllerViewModel(photos: photos)
        let fullScreenVC = FullScreenViewController(viewModel: viewModel)
        self.navigationController?.pushViewController(fullScreenVC, animated: true)
    }
}
