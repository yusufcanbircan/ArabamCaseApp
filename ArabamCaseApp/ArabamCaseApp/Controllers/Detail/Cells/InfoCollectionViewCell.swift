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
        // Initialization code
    }
    
    override func prepareForReuse() {
        nameLabel.text = nil
        valueLabel.text = nil
    }
    
    public func configure(viewModel: InfoCollectionViewCellViewModel) {
        valueLabel.text = viewModel.displayValue
        nameLabel.text = viewModel.title
        
    }

}
