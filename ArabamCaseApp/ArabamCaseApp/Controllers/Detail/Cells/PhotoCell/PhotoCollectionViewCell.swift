//
//  PhotoCollectionViewCell.swift
//  ArabamCaseApp
//
//  Created by Yusuf Can Bircan on 8.05.2023.
//

import UIKit

final class PhotoCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var advertImages: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        advertImages.image = nil
    }
    
    public func configure(viewModel: PhotoCollectionViewCellViewModel) {
        viewModel.fetchImage { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    self.advertImages.image = UIImage(data: data)
                }
            case .failure:
                break
            }
        }
    }

}


public extension UICollectionView {
    
    func isValid(indexPath: IndexPath) -> Bool {
        guard indexPath.section < numberOfSections,
              indexPath.row < numberOfItems(inSection: indexPath.section)
            else { return false }
        return true
    }
    
    /// SwifterSwift: Reload data with a completion handler.
    ///
    /// - Parameter completion: completion handler to run after reloadData finishes.
    func reloadData(_ completion: @escaping () -> Void) {
        UIView.animate(withDuration: 0, animations: {
            self.reloadData()
        }, completion: { _ in
            completion()
        })
    }
    
    /// SwifterSwift: Dequeue reusable UICollectionViewCell using class name.
        ///
        /// - Parameters:
        ///   - name: UICollectionViewCell type.
        ///   - indexPath: location of cell in collectionView.
        /// - Returns: UICollectionViewCell object with associated class name.
        func dequeueReusableCell<T: UICollectionViewCell>(withClass name: T.Type, for indexPath: IndexPath) -> T {
            guard let cell = dequeueReusableCell(withReuseIdentifier: String(describing: name), for: indexPath) as? T else {
                fatalError(
                    "Couldn't find UICollectionViewCell for \(String(describing: name)), make sure the cell is registered with collection view")
            }
            return cell
        }

        /// SwifterSwift: Dequeue reusable UICollectionReusableView using class name.
        ///
        /// - Parameters:
        ///   - kind: the kind of supplementary view to retrieve. This value is defined by the layout object.
        ///   - name: UICollectionReusableView type.
        ///   - indexPath: location of cell in collectionView.
        /// - Returns: UICollectionReusableView object with associated class name.
        func dequeueReusableSupplementaryView<T: UICollectionReusableView>(ofKind kind: String, withClass name: T.Type,
                                                                           for indexPath: IndexPath) -> T {
            guard let cell = dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: String(describing: name),
                for: indexPath) as? T else {
                fatalError(
                    "Couldn't find UICollectionReusableView for \(String(describing: name)), make sure the view is registered with collection view")
            }
            return cell
        }

        /// SwifterSwift: Register UICollectionReusableView using class name.
        ///
        /// - Parameters:
        ///   - kind: the kind of supplementary view to retrieve. This value is defined by the layout object.
        ///   - name: UICollectionReusableView type.
        func register<T: UICollectionReusableView>(supplementaryViewOfKind kind: String, withClass name: T.Type) {
            register(T.self, forSupplementaryViewOfKind: kind, withReuseIdentifier: String(describing: name))
        }

        /// SwifterSwift: Register UICollectionViewCell using class name.
        ///
        /// - Parameters:
        ///   - nib: Nib file used to create the collectionView cell.
        ///   - name: UICollectionViewCell type.
        func register<T: UICollectionViewCell>(nib: UINib?, forCellWithClass name: T.Type) {
            register(nib, forCellWithReuseIdentifier: String(describing: name))
        }

        /// SwifterSwift: Register UICollectionViewCell using class name.
        ///
        /// - Parameter name: UICollectionViewCell type.
        func register<T: UICollectionViewCell>(cellWithClass name: T.Type) {
            register(T.self, forCellWithReuseIdentifier: String(describing: name))
        }

        /// SwifterSwift: Register UICollectionReusableView using class name.
        ///
        /// - Parameters:
        ///   - nib: Nib file used to create the reusable view.
        ///   - kind: the kind of supplementary view to retrieve. This value is defined by the layout object.
        ///   - name: UICollectionReusableView type.
        func register<T: UICollectionReusableView>(nib: UINib?, forSupplementaryViewOfKind kind: String,
                                                   withClass name: T.Type) {
            register(nib, forSupplementaryViewOfKind: kind, withReuseIdentifier: String(describing: name))
        }

        /// SwifterSwift: Register UICollectionViewCell with .xib file using only its corresponding class.
        ///               Assumes that the .xib filename and cell class has the same name.
        ///
        /// - Parameters:
        ///   - name: UICollectionViewCell type.
        ///   - bundleClass: Class in which the Bundle instance will be based on.
        func register<T: UICollectionViewCell>(nibWithCellClass name: T.Type, at bundleClass: AnyClass? = nil) {
            let identifier = String(describing: name)
            var bundle: Bundle?

            if let bundleName = bundleClass {
                bundle = Bundle(for: bundleName)
            }

            register(UINib(nibName: identifier, bundle: bundle), forCellWithReuseIdentifier: identifier)
        }
}
