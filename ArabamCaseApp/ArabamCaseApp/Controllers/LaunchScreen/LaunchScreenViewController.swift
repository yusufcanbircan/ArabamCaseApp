//
//  LaunchScreenViewController.swift
//  ArabamCaseApp
//
//  Created by Yusuf Can Bircan on 12.05.2023.
//

import UIKit

final class LaunchScreenViewController: UIViewController {
    
    @IBOutlet private weak var logoImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        animate()
    }
    
    private func animate() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
            UIView.animate(withDuration: 1) {
                let size = self.view.frame.size.width * 3
                let x = size - self.view.frame.size.width
                let y = self.view.frame.size.height - size
                
                self.logoImageView.frame = CGRect(x: -(x/2), y: y/2, width: size, height: size)
            } completion: { done in
                if done {
                    UIView.animate(withDuration: 0.2) {
                        self.logoImageView.alpha = 0
                    } completion: { done in
                        
                        if done {
                            let vc = AdvertListingViewController()
                            let navigation = UINavigationController(rootViewController: vc)
                            navigation.modalTransitionStyle = .coverVertical
                            navigation.modalPresentationStyle = .fullScreen
                            
                            self.present(navigation, animated: true)
                        }
                    }
                }
            }
        })
    }
}
