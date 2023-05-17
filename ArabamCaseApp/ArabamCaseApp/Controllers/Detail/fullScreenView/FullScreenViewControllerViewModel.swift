//
//  FullScreenViewControllerViewModel.swift
//  ArabamCaseApp
//
//  Created by Yusuf Can Bircan on 11.05.2023.
//

import UIKit

final class FullScreenViewControllerViewModel {
        
    public var cellViewModels: [FullScreenPhotoCollectionViewCellViewModel] = []
    private var photos: [String]?

    init(photos: [String]?) {
        self.photos = photos
    }
    
    public func handlePhotoModels() {
        guard let photos else { return }
        for photo in photos {
            guard let urlString = photo.getPhotoUrl(resolution: .high), let url = URL(string: urlString) else { return }
            let viewModel = FullScreenPhotoCollectionViewCellViewModel(imageUrl: url)
            cellViewModels.append(viewModel)
        }
    }
}
