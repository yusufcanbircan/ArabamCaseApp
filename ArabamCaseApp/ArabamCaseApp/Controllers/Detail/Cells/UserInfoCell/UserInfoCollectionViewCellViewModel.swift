//
//  UserInfoCollectionViewCellViewModel.swift
//  ArabamCaseApp
//
//  Created by Yusuf Can Bircan on 10.05.2023.
//

import Foundation

final class UserInfoCollectionViewCellViewModel {
    private let name: String
    private let city: String
    private let price: String
    private let title: String
    
    public var nameString: String {
        return name
    }
    
    public var cityString: String {
        return city
    }
    
    public var titleString: String {
        return title
    }
    
    public var priceString: String {
        return price
    }
    
    init(name: String, city: String, price: String, title: String) {
        self.name = name
        self.city = city
        self.price = price
        self.title = title
    }
}
