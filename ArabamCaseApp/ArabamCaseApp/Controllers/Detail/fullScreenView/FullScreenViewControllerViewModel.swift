//
//  FullScreenViewControllerViewModel.swift
//  ArabamCaseApp
//
//  Created by Yusuf Can Bircan on 11.05.2023.
//

import Foundation
final class FullScreenViewControllerViewModel {
        
    public var cellViewModels: [FullScreenPhotoCollectionViewCellViewModel] = []
    private var photos: [String] = [] {
        didSet {
            for photo in photos {
                let viewModel = FullScreenPhotoCollectionViewCellViewModel(imageUrl: URL(string: .getPhotoUrl(url: photo, resolution: "1920x1080") ?? ""))
                
                print(viewModel)
            }
        }
    }
    
    
    
    init(photos: [String]) {
        self.photos = photos
    }
    
    // MARK: - Private
    
}
