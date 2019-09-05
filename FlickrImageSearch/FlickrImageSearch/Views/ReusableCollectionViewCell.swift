//
//  ReusableCollectionViewCell.swift
//  FlickrImageSearch
//
//  Created by Dimitar Dimitrov on 5.09.19.
//  Copyright © 2019 Dimitar Dimitrov. All rights reserved.
//

import UIKit

typealias ReusableCollectionViewCell = ReusableView & UICollectionViewCell

extension UICollectionView {

    func dequeueCell<T: ReusableCollectionViewCell>(for indexPath: IndexPath) -> T {
        guard let cell = self.dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath) as? T else {

            fatalError("Wrong cell class")
        }
        return cell
    }

    func register(_ cellType: ReusableCollectionViewCell.Type) {

        let cellNib = UINib(nibName: String(describing: cellType), bundle: Bundle.main)
        self.register(cellNib, forCellWithReuseIdentifier: cellType.reuseIdentifier)
    }
}
