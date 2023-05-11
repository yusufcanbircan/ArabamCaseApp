//
//  Int.swift
//  ArabamCaseApp
//
//  Created by Yusuf Can Bircan on 11.05.2023.
//

import Foundation

extension Int {
    static func formatNumber(number: Int) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        var str = numberFormatter.string(from: NSNumber(value: number)) ?? "\(number)"
        str = str.replacingOccurrences(of: ",", with: ".")
        return str
    }
}
