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
        
        let request = AdvertRequest.listing(sort: 1, sortDirection: 0, take: 10)
        print(request.path)
        
        var urlComponents = URLComponents(string: request.baseURL)
        urlComponents?.path = request.path.rawValue
        urlComponents?.queryItems = request.urlQueryItems
        
        guard let url = urlComponents?.url else { return }
        
        print(url)
        
        
    }


}
