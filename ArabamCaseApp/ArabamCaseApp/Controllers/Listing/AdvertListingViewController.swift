//
//  AdvertListingViewController.swift
//  ArabamCaseApp
//
//  Created by Yusuf Can Bircan on 6.05.2023.
//

import UIKit

protocol AdvertListingViewControllerProtocol: AnyObject {
    func advertListing(view: AdvertListingViewController, didSelectedAdvert advert: AdvertDetailResponse)
}

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
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Adverts"
        configureTableView()
        spinner.startAnimating()
        viewModel.delegate = self
        viewModel.fetchListingAdverts()
    }
    
    // MARK: - Private
    
    private func configureTableView() {
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.isHidden = true
        self.tableView.alpha = 0
        let nib = UINib(nibName: AdvertListingTableViewCell.className, bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: AdvertListingTableViewCell.className)
//        let  footerNib = UINib(nibName: FooterLoadingView.className, bundle: nil)
//        self.tableView.register(footerNib, forHeaderFooterViewReuseIdentifier: FooterLoadingView.className)
    }

}

// MARK: - TableView
extension AdvertListingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.viewModel.cellViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: AdvertListingTableViewCell.className, for: indexPath) as? AdvertListingTableViewCell {
            
            let model = viewModel.cellViewModels[indexPath.row]
            cell.configure(with: model)
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let advert = viewModel.cellViewModels[indexPath.row]
        
        self.didSelectAdvert(advert.advertId)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        view.frame.width/4
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == viewModel.cellViewModels.count - 1 {
            DispatchQueue.global(qos: .userInitiated).asyncAfter(deadline: .now() + 0.4) {
                self.viewModel.fetchListingAdverts()
            }
        }
    }
    
}

// MARK: -
extension AdvertListingViewController{
    
    private func didSelectAdvert(_ advert: Int) {
        let request = AdvertRequest.detail(id: "\(advert)")
        print(request)
        AdvertDetailService().fetchListingObjects(request: request) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let advert):
                let viewModel = AdvertDetailViewControllerViewModel(advert: advert)
                let detailVC = AdvertDetailViewController(viewModel: viewModel)
                self.navigationController?.pushViewController(detailVC, animated: true)
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
    
//    private func handleAdvertDetail(advert: AdvertDetailResponse) {
//        let viewModel = AdvertDetailViewControllerViewModel(advert: advert)
//        let detailVC = AdvertDetailViewController(viewModel: viewModel)
//        self.navigationController?.pushViewController(detailVC, animated: true)
//    }
}

// MARK: - AdvertListingViewControllerViewModelDelegate
extension AdvertListingViewController: AdvertListingViewControllerViewModelDelegate {
    func didLoadAdverts(isInitial: Bool) {
        
        tableView.reloadData()
        
        if isInitial {
            spinner.stopAnimating()
            tableView.isHidden = false
            
            UIView.animate(withDuration: 0.4) {
                self.tableView.alpha = 1
            }
        }
    }
}
