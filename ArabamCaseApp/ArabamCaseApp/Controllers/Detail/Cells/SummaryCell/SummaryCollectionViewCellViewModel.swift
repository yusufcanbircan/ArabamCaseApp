//
//  SummaryCollectionViewCellViewModel.swift
//  ArabamCaseApp
//
//  Created by Yusuf Can Bircan on 10.05.2023.
//

import Foundation

final class SummaryCollectionViewCellViewModel {
    private let summary: String
    
    var summaryString: String { summary }
    
    init(summary: String) {
        self.summary = summary
    }
}
