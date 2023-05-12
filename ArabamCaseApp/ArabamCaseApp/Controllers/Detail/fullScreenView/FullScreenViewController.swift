//
//  FullScreenViewController.swift
//  ArabamCaseApp
//
//  Created by Yusuf Can Bircan on 11.05.2023.
//

import UIKit

final class FullScreenViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    private let viewModel: FullScreenViewControllerViewModel
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.handlePhotoModels()
        setUpCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    required init(viewModel: FullScreenViewControllerViewModel) {
        self.viewModel = viewModel
        super.init(nibName: String(describing: type(of: self)), bundle: Bundle(for: Self.self))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBAction func buttonTapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Private
    private func setUpCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(nibWithCellClass: FullScreenPhotoCollectionViewCell.self)
        
        let layout = UICollectionViewFlowLayout()
        let width = self.collectionView.frame.width
        let height = self.collectionView.frame.height
        
        layout.itemSize = CGSize(width: width, height: height)
        layout.scrollDirection = .horizontal
        
        collectionView.collectionViewLayout = layout
    }

}

extension FullScreenViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.cellViewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withClass: FullScreenPhotoCollectionViewCell.self, for: indexPath)
        cell.configure(viewModel: viewModel.cellViewModels[indexPath.row])
        return cell
    }
    
    
}
