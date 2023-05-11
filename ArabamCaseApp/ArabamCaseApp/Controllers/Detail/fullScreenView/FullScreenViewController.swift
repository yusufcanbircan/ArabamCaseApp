//
//  FullScreenViewController.swift
//  ArabamCaseApp
//
//  Created by Yusuf Can Bircan on 11.05.2023.
//

import UIKit

final class FullScreenViewController: UIViewController {
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    
    private let viewModel: FullScreenViewControllerViewModel
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(viewModel.cellViewModels)
    }
    
    required init(viewModel: FullScreenViewControllerViewModel) {
        self.viewModel = viewModel
        super.init(nibName: String(describing: type(of: self)), bundle: Bundle(for: Self.self))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private
    private func setUpCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        
        let layout = UICollectionViewFlowLayout()
        let width = self.collectionView.frame.width
        let height = self.collectionView.frame.height
        
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: width, height: height)
        
//        layout.minimumInteritemSpacing = 5
//        layout.minimumLineSpacing = 5
        
        collectionView.collectionViewLayout = layout
    }

}

extension FullScreenViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
    
    
}
