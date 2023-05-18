//
//  InfoCollectionViewCellViewModel.swift
//  ArabamCaseApp
//
//  Created by Yusuf Can Bircan on 8.05.2023.
//

import UIKit

final class InfoCollectionViewCellViewModel {
    private let property: Property
    
    var name: String {
        return getName()
    }
    
    var value: String {
        return getValue()
    }
    
    init(property: Property) {
        self.property = property
    }
}

extension InfoCollectionViewCellViewModel {
    private func getName() -> String {
        guard let name = property.name else { return "-"}
        return name
    }
    
    private func getValue() -> String {
        guard let value = property.value else { return "-"}
        return value
    }
}

