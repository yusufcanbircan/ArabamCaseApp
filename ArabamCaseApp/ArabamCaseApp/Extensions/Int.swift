//
//  Int.swift
//  ArabamCaseApp
//
//  Created by Yusuf Can Bircan on 11.05.2023.
//

import Foundation

extension Int {
    func formatNumber() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        var formatted = numberFormatter.string(from: NSNumber(value: self)) ?? "\(self)"
        formatted = formatted.replacingOccurrences(of: ",", with: ".")
        return formatted
    }
}
