//
//  ViewController.swift
//  ArabamCaseApp
//
//  Created by Yusuf Can Bircan on 4.05.2023.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        let request = AdvertRequest.listing(sort: 1, sortDirection: 0, take: 15)
        
        AdvertListingService().fetchListingObjects(request: request) { result in
            switch result {
            case .success(let success):
                print(success)
            case .failure(let failure):
                print(failure)
            }
        }
        
        
    }


}
