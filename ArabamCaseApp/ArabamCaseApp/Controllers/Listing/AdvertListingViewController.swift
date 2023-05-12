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
    
    private let pickerView = UIPickerView(frame: CGRect(x: 0, y: UIScreen.main.bounds.height, width: UIScreen.main.bounds.width, height: 216))
    private let toolbar = UIToolbar(frame: CGRect(x: 0, y: UIScreen.main.bounds.height, width: UIScreen.main.bounds.width, height: 44))
    
    // MARK: - ViewModel
    private let viewModel = AdvertListingViewControllerViewModel()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureTableView()
        configurePickerView()
        setUpViewModel()
    }
    
    // MARK: - Private
    
    private func configureUI() {
        title = "İlanlar"
        setUpRightButtonItem()
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

// MARK: - PickerViewDelegate

extension AdvertListingViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    private func configurePickerView() {
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.backgroundColor = .white
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
}

// MARK: -
extension AdvertListingViewController {
    
    private func didSelectAdvert(_ advert: Int) {
        let request = AdvertRequest.detail(id: "\(advert)")
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
        // handle push error
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
            image: UIImage(systemName: "line.3.horizontal.decrease.circle"),
            style: .plain,
            target: self,
            action: #selector(didTapChangeSorting)
        )
    }
    
    @objc
    private func didTapChangeSorting() {

        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(pickerDoneButtonPressed))
        toolbar.setItems([doneButton], animated: true)
        
        self.view.addSubview(pickerView)
        self.view.addSubview(toolbar)
        
        UIView.animate(withDuration: 0.3) {
            self.pickerView.frame = CGRect(x: 0, y: UIScreen.main.bounds.height - 216, width: UIScreen.main.bounds.width, height: 216)
            self.toolbar.frame = CGRect(x: 0, y: UIScreen.main.bounds.height - 260, width: UIScreen.main.bounds.width, height: 44)
        }
     }

     @objc func pickerDoneButtonPressed() {
         let type = pickerView.selectedRow(inComponent: 0)
         let direction = pickerView.selectedRow(inComponent: 1)
         
         viewModel.changeSorting(type: type, direction: direction)
         
         UIView.animate(withDuration: 0.3) {
             self.pickerView.frame = CGRect(x: 0, y: UIScreen.main.bounds.height, width: UIScreen.main.bounds.width, height: 216)
             self.toolbar.frame = CGRect(x: 0, y: UIScreen.main.bounds.height, width: UIScreen.main.bounds.width, height: 44)
         }
     }
}
