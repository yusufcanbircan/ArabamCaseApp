//
//  AdvertListingTableViewCell.swift
//  ArabamCaseApp
//
//  Created by Yusuf Can Bircan on 6.05.2023.
//

import UIKit

final class AdvertListingTableViewCell: UITableViewCell {

    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var advertImage: UIImageView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    override func prepareForReuse() {
        priceLabel.text = nil
        locationLabel.text = nil
        titleLabel.text = nil
        advertImage.image = nil
    }
    
    public func configure(with viewModel: AdvertListingTableViewCellViewModel) {
        priceLabel.text = viewModel.priceLabel
        locationLabel.text = viewModel.locationLabel
        titleLabel.text = viewModel.titleLabel
        viewModel.fetchImage { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    self.advertImage.image = UIImage(data: data)
                }
            case .failure(let error):
                print(String(describing: error))
                break
            }
        }
    }
    
}
