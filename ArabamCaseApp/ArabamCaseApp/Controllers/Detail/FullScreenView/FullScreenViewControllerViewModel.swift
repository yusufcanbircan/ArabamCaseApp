//
//  FullScreenViewControllerViewModel.swift
//  ArabamCaseApp
//
//  Created by Yusuf Can Bircan on 11.05.2023.
//

import UIKit

protocol FullScreenViewDataSourceProtocol {
    var numberOfSection: Int { get }
    func numberOfItemsInSection(section: Int) -> Int
}

final class FullScreenViewControllerViewModel {
    
    private var photos: [String]?

    // MARK: - Init
    init(photos: [String]?) {
        self.photos = photos
    }
}

// MARK: - DataSource
extension FullScreenViewControllerViewModel: FullScreenViewDataSourceProtocol {
    var numberOfSection: Int {
        1
    }
    
    func numberOfItemsInSection(section: Int) -> Int {
        guard let photos else { return 0 }
        return photos.count
    }
    
    func getAdvertPhoto(for index: Int) -> URL? {
        guard let photos, let urlString = photos[index].getPhotoUrl(resolution: .high),
              let url = URL(string: urlString) else { return nil }
        return url
    }
}
