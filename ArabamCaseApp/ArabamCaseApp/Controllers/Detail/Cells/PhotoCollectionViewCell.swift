//
//  PhotoCollectionViewCell.swift
//  ArabamCaseApp
//
//  Created by Yusuf Can Bircan on 8.05.2023.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var advertImages: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        advertImages = nil
    }
    
    public func configure(viewModel: PhotoCollectionViewCellViewModel) {
        viewModel.fetchImage { [weak self] result in
            switch result {
            case .success(let data):
                DispatchQueue.global(qos: .userInteractive).async {
                    self?.advertImages.image = UIImage(data: data)
                }
            case .failure:
                break
            }
        }
    }

}
