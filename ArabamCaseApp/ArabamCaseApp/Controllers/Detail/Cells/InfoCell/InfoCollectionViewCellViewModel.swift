//
//  InfoCollectionViewCellViewModel.swift
//  ArabamCaseApp
//
//  Created by Yusuf Can Bircan on 8.05.2023.
//

import UIKit

final class InfoCollectionViewCellViewModel {
    private let type: `Type`
    private let value: String
    
    public var title: String {
        type.displayTitle
    }
    
    public var displayValue: String {
        return value
    }
    
    enum `Type`: String {
        case km
        case color
        case year
        case gear
        case fuel
        case owner
        case model
        case date
        
        var displayTitle: String {
            switch self {
            case .km,
                    .color,
                    .year,
                    .gear,
                    .fuel,
                    .owner,
                    .model,
                    .date:
                return rawValue.uppercased()
            }
        }
    }
    
    init(type: `Type`, value: String) {
        self.type = type
        self.value = value
    }
}
