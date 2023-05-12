//
//  FullScreenPhotoCollectionViewCell.swift
//  ArabamCaseApp
//
//  Created by Yusuf Can Bircan on 11.05.2023.
//

import UIKit

final class FullScreenPhotoCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var advertImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        handleZoom()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        advertImage.image = nil
    }
    
    // MARK: - Private
    
    private func handleZoom() {
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(handlePinchGesture(_:)))
        advertImage.isUserInteractionEnabled = true
        advertImage.addGestureRecognizer(pinchGesture)
    }
    
    @objc
    private func handlePinchGesture(_ sender: UIPinchGestureRecognizer) {
        guard let view = sender.view else { return }
        
        if sender.state == .changed || sender.state == .ended {
            let currentScale = view.frame.size.width / view.bounds.size.width
            var newScale = currentScale * sender.scale
            
            newScale = max(1, min(newScale, 3))
            
            let transform = CGAffineTransform(scaleX: newScale, y: newScale)
            view.transform = transform
            
            sender.scale = 1
        }
    }
    
    
    // MARK: - Public
    
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
