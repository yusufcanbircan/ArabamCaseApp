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
    
    private let pickerView: UIPickerView = UIPickerView()
    
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
        configureUI()
        configureTableView()
        configurePickerView()
        setUpViewModel()
        //spinner.startAnimating()
        setUpRightButtonItem()
    }
    
    // MARK: - Private
    
    private func configureUI() {
        title = "Ilanlar"
    }
    
    private func setUpViewModel() {
        viewModel.delegate = self
        viewModel.fetchListingAdverts()
    }
    
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

extension AdvertListingViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    private func configurePickerView() {
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        component == 0 ? viewModel.sortingTypes.count : viewModel.sortingDirections.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        component == 0 ? viewModel.sortingTypes[row] : viewModel.sortingDirections[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
    }
}

// MARK: -
extension AdvertListingViewController {
    
    private func didSelectAdvert(_ advert: Int) {
        let request = AdvertRequest.detail(id: "\(advert)")
        print(request)
        AdvertDetailService().fetchListingObjects(request: request) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let advert):
                self.handleAdvertDetail(advert: advert)
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
    
    private func handleAdvertDetail(advert: AdvertDetailResponse) {
        
        DispatchQueue.main.async {
            let viewModel = AdvertDetailViewControllerViewModel(advert: advert)
            let detailVC = AdvertDetailViewController(viewModel: viewModel)
            self.navigationController?.pushViewController(detailVC, animated: true)
        }
        
        
        
    }
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

// MARK: - RightBarButtonItems

extension AdvertListingViewController {
    private func setUpRightButtonItem() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .edit,
            target: self,
            action: #selector(didTapChangeSorting)
        )
    }
    
    @objc
    private func didTapChangeSorting() {
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.backgroundColor = .white

         let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 44))
         let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(pickerDoneButtonPressed))
         toolbar.setItems([doneButton], animated: true)

         let inputAccessoryView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: toolbar.frame.height + pickerView.frame.height))
         inputAccessoryView.addSubview(toolbar)
         inputAccessoryView.addSubview(pickerView)

         pickerView.frame.origin.y = toolbar.frame.maxY

         view.endEditing(true)
         view.addSubview(inputAccessoryView)

         UIView.animate(withDuration: 0.3) {
             inputAccessoryView.frame.origin.y = self.view.frame.height - inputAccessoryView.frame.height
         }
     }

     @objc func pickerDoneButtonPressed() {
         view.subviews.last?.removeFromSuperview()
     }
}
