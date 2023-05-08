//
//  AdvertDetailViewController.swift
//  ArabamCaseApp
//
//  Created by Yusuf Can Bircan on 8.05.2023.
//

import UIKit

protocol AdvertDetailViewControllerProtocol: AnyObject {
    func getViewModel(viewModel: AdvertDetailViewControllerViewModel)
}

final class AdvertDetailViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    private let viewModel: AdvertDetailViewControllerViewModel
    
    init( viewModel: AdvertDetailViewControllerViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpCollectionView()
    }
    
    private func setUpCollectionView() {
        createCollectionViewLayout()
//        collectionView.delegate = self
//        collectionView.dataSource = self
    }
    
    private func createCollectionViewLayout() {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, _ in
            return self.createSection(for: sectionIndex)
        }
        self.collectionView.collectionViewLayout = layout
        self.collectionView.register(PhotoCollectionViewCell.self,
                                forCellWithReuseIdentifier: PhotoCollectionViewCell.className)
        self.collectionView.register(InfoCollectionViewCell.self, forCellWithReuseIdentifier: InfoCollectionViewCell.className)
    }
    
    private func createSection(for sectionIndex: Int) -> NSCollectionLayoutSection {
        let sectionTypes = viewModel.sections
        
        switch sectionTypes[sectionIndex] {
        case .photo:
            return viewModel.createPhotoSectionLayout()
        case .information:
            return viewModel.createInformationSectionLayout()
        }
    }

}
