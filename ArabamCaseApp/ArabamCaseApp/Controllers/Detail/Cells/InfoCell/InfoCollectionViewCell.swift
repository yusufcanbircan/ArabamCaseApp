//
//  InfoCollectionViewCell.swift
//  ArabamCaseApp
//
//  Created by Yusuf Can Bircan on 8.05.2023.
//

import UIKit

final class InfoCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var valueLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        nameLabel.text = nil
        valueLabel.text = nil
    }
    
    func configure(viewModel: InfoCollectionViewCellViewModel) {
        self.valueLabel.text = viewModel.value
        self.nameLabel.text = viewModel.name
    }
}
