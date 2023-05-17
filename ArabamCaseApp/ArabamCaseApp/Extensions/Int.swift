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
        var str = numberFormatter.string(from: NSNumber(value: self)) ?? "\(self)"
        str = str.replacingOccurrences(of: ",", with: ".")
        return str
    }
    
    func formatAsDecimal() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        return numberFormatter.string(from: NSNumber(value: self)) ?? "\(self)"
    }
}
