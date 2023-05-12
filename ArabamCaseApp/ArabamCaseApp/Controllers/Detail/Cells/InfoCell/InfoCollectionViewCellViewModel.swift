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
            case .km: return "km"
            case .color: return "renk"
            case .date: return "tarih"
            case .fuel: return "yakıt"
            case .gear: return "vites"
            case .model: return "model"
            case .owner: return "sahibi"
            case .year: return "yıl"
                
            }
        }
    }
    
    init(type: `Type`, value: String) {
        self.type = type
        self.value = value
    }
}
