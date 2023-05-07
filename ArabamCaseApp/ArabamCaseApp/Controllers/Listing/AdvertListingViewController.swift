//
//  AdvertListingViewController.swift
//  ArabamCaseApp
//
//  Created by Yusuf Can Bircan on 6.05.2023.
//

import UIKit

final class AdvertListingViewController: UIViewController {
    
    // UI Elements
    @IBOutlet weak var tableView: UITableView!
    
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .medium)
        spinner.hidesWhenStopped = true
        spinner.translatesAutoresizingMaskIntoConstraints = false
        
        return spinner
    }()
    
    private let viewModel = AdvertListingViewControllerViewModel()
    
    var items = ["KALAFAT OTO'DAN 2003 MERCEDES-BENZ E 200 KOMP.ELEGANCE HATASIZ",
                 "KALAFAT OTO'DAN 2003 MERCEDES-BENZ E 200 KOMP.ELEGANCE HATASIZ",
                 "KALAFAT OTO'DAN 2003 MERCEDES-BENZ E 200 KOMP.ELEGANCE HATASIZ",
                 "KALAFAT OTO'DAN 2003 MERCEDES-BENZ E 200 KOMP.ELEGANCE HATASIZ",
                 "KALAFAT OTO'DAN 2003 MERCEDES-BENZ E 200 KOMP.ELEGANCE HATASIZ",
                 "KALAFAT OTO'DAN 2003 MERCEDES-BENZ E 200 KOMP.ELEGANCE HATASIZ",
                 "KALAFAT OTO'DAN 2003 MERCEDES-BENZ E 200 KOMP.ELEGANCE HATASIZ",
                 "KALAFAT OTO'DAN 2003 MERCEDES-BENZ E 200 KOMP.ELEGANCE HATASIZ"]
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Adverts"
        configureTableView()
        spinner.startAnimating()
        viewModel.fetchListingAdverts()
    
    }
    
    // MARK: - Private
    
    private func configureTableView() {
        self.tableView.dataSource = self
        self.tableView.delegate = self
//        self.tableView.isHidden = true
//        self.tableView.alpha = 0
        let nib = UINib(nibName: AdvertListingTableViewCell.className, bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: AdvertListingTableViewCell.className)
    }

}

// MARK: - TableView
extension AdvertListingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.items.count//self.viewModel.cellViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: AdvertListingTableViewCell.className, for: indexPath) as? AdvertListingTableViewCell {
            
            let model = AdvertListingTableViewCellViewModel(priceLabel: items[indexPath.row], locationLabel: items[indexPath.row], titleLabel: items[indexPath.row], advertImage: URL(string: "https://arbstorage.mncdn.com/ilanfotograflari/2020/11/17/15996479/d4c51893-4420-48cf-afc2-213da87804e4_image_for_silan_15996479_800x600.jpg"))
            cell.configure(with: model)
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        view.frame.width/4
    }
    
}

// MARK: - AdvertListingViewControllerViewModelDelegate
extension AdvertListingViewController: AdvertListingViewControllerViewModelDelegate {
    func didLoadAdverts(isInitial: Bool) {
        
        if isInitial {
            spinner.stopAnimating()
            tableView.isHidden = false
            tableView.reloadData()
            
            UIView.animate(withDuration: 0.4) {
                self.tableView.alpha = 1
            }
        }
        
    }
    
    func didSelectAdvert(_ advert: AdvertDetailResponse) {
        
    }
}
