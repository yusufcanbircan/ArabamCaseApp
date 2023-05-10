//
//  SummaryCollectionViewCell.swift
//  ArabamCaseApp
//
//  Created by Yusuf Can Bircan on 10.05.2023.
//

import UIKit

final class SummaryCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var summaryLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        summaryLabel.text = nil
    }
    
    public func configure(viewModel: SummaryCollectionViewCellViewModel) {
        self.summaryLabel.text = viewModel.summaryString
    }

}
