//
//  UserInfoCollectionViewCell.swift
//  ArabamCaseApp
//
//  Created by Yusuf Can Bircan on 10.05.2023.
//

import UIKit

final class UserInfoCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        nameLabel.text = nil
        cityLabel.text = nil
        priceLabel.text = nil
        titleLabel.text = nil
    }
    
    public func configure(viewModel: UserInfoCollectionViewCellViewModel) {
        self.nameLabel.text = viewModel.name
        self.cityLabel.text = viewModel.city
        self.priceLabel.text = viewModel.price
        self.titleLabel.text = viewModel.title
    }
}
