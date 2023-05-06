//
//  NSObject.swift
//  ArabamCaseApp
//
//  Created by Yusuf Can Bircan on 6.05.2023.
//

import Foundation

extension NSObject {
    static var className: String {
        return NSStringFromClass(self).components(separatedBy: ".").last!
    }
}
