//
//  InfoCollectionViewCell.swift
//  ArabamCaseApp
//
//  Created by Yusuf Can Bircan on 8.05.2023.
//

import UIKit

final class InfoCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        nameLabel.text = nil
        valueLabel.text = nil
    }
    
    public func configure(viewModel: InfoCollectionViewCellViewModel) {
        self.valueLabel.text = viewModel.displayValue
        self.nameLabel.text = viewModel.title
    }

}
