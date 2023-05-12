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
    static func getPhotoUrl(url:String?, resolution: resolution = .low) -> String? {
        let url = url?.replacingOccurrences(of: "{0}", with: resolution.rawValue)
        return url
    }
    static var unknownCase = "unknown"
    
    static func getObject(advert: AdvertDetailResponse, name: String) -> String {
        guard let properties = advert.properties else { return "-"}
        var property = properties.first(where: { $0.name == name })?.value ?? "bilinmiyor"
        
        return property == "" ? "-" : property
    }
    
    static func getCity(advert: AdvertDetailResponse) -> String {
        "\(advert.location?.townName ?? "")/\(advert.location?.cityName ?? "")"
    }
    
    static func getPrice(advert: AdvertDetailResponse) -> String {
        "\(Int.formatNumber(number: advert.price ?? 0)) TL"
    }
    
    static func getCity(advert: AdvertListingResponse) -> String {
        "\(advert.location?.townName ?? "")/\(advert.location?.cityName ?? "")"
    }
    
    static func getPrice(advert: AdvertListingResponse) -> String {
        "\(Int.formatNumber(number: advert.price ?? 0)) TL"
    }
    
    static func getSummary(advert: AdvertDetailResponse) -> String {
        guard let text = advert.text else { return ""}
        return text == "" ? "Bu ilana detay eklenmemiş!" : text.modifyHtmlContentWithCenteredArial(fontSize: 13)
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


