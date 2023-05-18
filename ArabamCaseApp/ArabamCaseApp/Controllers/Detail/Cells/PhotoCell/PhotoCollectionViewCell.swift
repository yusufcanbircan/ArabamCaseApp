//
//  PhotoCollectionViewCell.swift
//  ArabamCaseApp
//
//  Created by Yusuf Can Bircan on 8.05.2023.
//

import UIKit

final class PhotoCollectionViewCell: UICollectionViewCell {

    @IBOutlet private weak var advertImages: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        advertImages.image = nil
    }
    
    func configure(viewModel: PhotoCollectionViewCellViewModel) {
        viewModel.fetchImage { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    self.advertImages.image = UIImage(data: data)
                }
            case .failure:
                break
            }
        }
    }
}
