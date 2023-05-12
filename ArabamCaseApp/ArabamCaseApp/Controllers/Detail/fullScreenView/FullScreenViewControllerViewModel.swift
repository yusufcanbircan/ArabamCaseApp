//
//  FullScreenViewControllerViewModel.swift
//  ArabamCaseApp
//
//  Created by Yusuf Can Bircan on 11.05.2023.
//

import UIKit

final class FullScreenViewControllerViewModel {
        
    public var cellViewModels: [FullScreenPhotoCollectionViewCellViewModel] = []
    private var photos: [String]

    init(photos: [String]) {
        self.photos = photos
    }
    
    public func handlePhotoModels() {
        for photo in photos {
            let viewModel = FullScreenPhotoCollectionViewCellViewModel(imageUrl: URL(string: .getPhotoUrl(url: photo, resolution: .high) ?? ""))
            cellViewModels.append(viewModel)
        }
    }
}
