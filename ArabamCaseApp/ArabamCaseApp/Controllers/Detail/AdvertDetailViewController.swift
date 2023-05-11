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
    
    required init(viewModel: AdvertDetailViewControllerViewModel) {
        self.viewModel = viewModel
        super.init(nibName: String(describing: type(of: self)), bundle: Bundle(for: Self.self))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = viewModel.detailTitle
        
        setUpCollectionView()
    }
    
    private func setUpCollectionView() {
        createCollectionViewLayout()
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func createCollectionViewLayout() {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, _ in
            return self.createSection(for: sectionIndex)
        }
        self.collectionView.collectionViewLayout = layout
        self.collectionView.register(nibWithCellClass: PhotoCollectionViewCell.self)
        self.collectionView.register(nibWithCellClass: InfoCollectionViewCell.self)
        self.collectionView.register(nibWithCellClass: UserInfoCollectionViewCell.self)
        self.collectionView.register(nibWithCellClass: SummaryCollectionViewCell.self)
    }
    
    private func createSection(for sectionIndex: Int) -> NSCollectionLayoutSection {
        let sectionTypes = viewModel.sections

        switch sectionTypes[sectionIndex] {
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

extension AdvertDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        viewModel.sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let sectionType = viewModel.sections[section]
        
        switch sectionType {
        case .photo(let viewModels):
            if let viewModels {
                return viewModels.count
            }
            return 1
        case .userInformation:
            return 1
        case .information(let viewModels):
            return viewModels.count
        case .summary:
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let sectionType = viewModel.sections[indexPath.section]
        
        switch sectionType {
        case .photo(let viewModels):
            let cell = collectionView.dequeueReusableCell(withClass: PhotoCollectionViewCell.self, for: indexPath)
            if let viewModels {
                cell.configure(viewModel: viewModels[indexPath.row])
            }
            // swifterswift
            return cell
            
        case .userInformation(let viewModel):
            let cell = collectionView.dequeueReusableCell(withClass: UserInfoCollectionViewCell.self, for: indexPath)
            cell.configure(viewModel: viewModel)
            return cell
            
        case .information(let viewModels):
            let cell = collectionView.dequeueReusableCell(withClass: InfoCollectionViewCell.self, for: indexPath)
            cell.configure(viewModel: viewModels[indexPath.row])
            return cell
            
        case .summary(let viewModel):
            let cell = collectionView.dequeueReusableCell(withClass: SummaryCollectionViewCell.self, for: indexPath)
            cell.configure(viewModel: viewModel)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let sectionType = viewModel.sections[indexPath.section]
        
        switch sectionType {
        case .photo:
            self.handleFullScreen(photos: viewModel.photos)
        case .userInformation:
            return
        case .information:
            return
        case .summary:
            return
        }
    }
    
    private func handleFullScreen(photos: [String]) {
        // handle push error
        DispatchQueue.main.async {
            let viewModel = FullScreenViewControllerViewModel(photos: photos)
            let fullScreenVC = FullScreenViewController(viewModel: viewModel)
            self.navigationController?.pushViewController(fullScreenVC, animated: true)
        }
    }
}
