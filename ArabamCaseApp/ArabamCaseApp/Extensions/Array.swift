//
//  Array.swift
//  ArabamCaseApp
//
//  Created by Yusuf Can Bircan on 17.05.2023.
//

import Foundation

public extension Array where Element: Equatable {
    var unique: [Element] {
        var uniqueValues: [Element] = []
        forEach { item in
            if !uniqueValues.contains(item) {
                uniqueValues += [item]
            }
        }
        return uniqueValues
    }
    
    var intArrayToNSNumber: [NSNumber] {
        guard let array = Array(self) as? [Int] else { return [] }
        return array.map({ NSNumber(value: $0) })
    }
    
    subscript (safe index: Int) -> Element? {
        return self.indices ~= index ? self[index] : nil
    }
}
