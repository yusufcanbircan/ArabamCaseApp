//
//  SummaryCollectionViewCell.swift
//  ArabamCaseApp
//
//  Created by Yusuf Can Bircan on 10.05.2023.
//

import UIKit

final class SummaryCollectionViewCell: UICollectionViewCell {

    @IBOutlet private weak var summaryLabel: UILabel!
    
    override func awakeFromNib() {
    }
    
    override func prepareForReuse() {
        summaryLabel.text = nil
    }
    
    func configure(viewModel: SummaryCollectionViewCellViewModel) {
        self.summaryLabel.attributedText = viewModel.summaryString.html2AttributedString
    }
}
