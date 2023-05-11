//
//  FullScreenPhotoCollectionViewCell.swift
//  ArabamCaseApp
//
//  Created by Yusuf Can Bircan on 11.05.2023.
//

import UIKit

class FullScreenPhotoCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var advertImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        advertImage.image = nil
    }
    
    public func configure(viewModel: FullScreenPhotoCollectionViewCellViewModel) {
        viewModel.fetchImage { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    self.advertImage.image = UIImage(data: data)
                }
            case .failure:
                break
            }
        }
    }

}
