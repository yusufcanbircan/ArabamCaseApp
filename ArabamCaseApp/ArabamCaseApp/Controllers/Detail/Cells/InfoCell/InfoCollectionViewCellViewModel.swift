//
//  InfoCollectionViewCellViewModel.swift
//  ArabamCaseApp
//
//  Created by Yusuf Can Bircan on 8.05.2023.
//

import UIKit

final class InfoCollectionViewCellViewModel {
    private let property: Property
    
    var name: String { getName() }
    
    var value: String { getValue() }
    
    init(property: Property) {
        self.property = property
    }
}

extension InfoCollectionViewCellViewModel {
    private func getName() -> String {
        guard let name = property.name else { return "-"}
        switch name {
        case "km": return "km"
        case "color": return "renk"
        case "year": return "yıl"
        case "gear": return "vites"
        case "fuel": return "yakıt"
        default: return "-"
        }
    }
    
    private func getValue() -> String {
        guard let value = property.value else { return "-"}
        return value == "" ? "-" : value
    }
}

