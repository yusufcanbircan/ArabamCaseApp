//
//  String.swift
//  ArabamCaseApp
//
//  Created by Yusuf Can Bircan on 11.05.2023.
//

import Foundation

extension String {
    static func getPhotoUrl(url:String?, resolution: String = "240x180") -> String? {
        let url = url?.replacingOccurrences(of: "{0}", with: resolution)
        return url
    }
}
