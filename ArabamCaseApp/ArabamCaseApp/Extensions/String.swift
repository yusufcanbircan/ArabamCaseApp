//
//  String.swift
//  ArabamCaseApp
//
//  Created by Yusuf Can Bircan on 11.05.2023.
//

import Foundation

@frozen
enum resolution: String {
    case low = "240x180"
    case medium = "800x600"
    case high = "1920x1080"
}

extension String {
    func getPhotoUrl(resolution: resolution = .low) -> String? {
        let url = self.replacingOccurrences(of: "{0}", with: resolution.rawValue)
        return url
    }
    
    func getSummary() -> String {
        return self == "" ? "" : self.modifyHtmlContentWithCenteredArial(fontSize: 13)
    }
    
    func modifyHtmlContentWithCenteredArial(fontSize: Int) -> String {
        let style = "<html><head><style>body{text-align:center;font-size:\(fontSize)px;font-family: \"Arial\", Helvetica, sans-serif;}</style></head>"
        return "\(style)\(self)"
    }
    
    var html2AttributedString: NSAttributedString? {
        Data(utf8).html2AttributedString
    }
    
    var html2String: String {
        html2AttributedString?.string ?? ""
    }
}


