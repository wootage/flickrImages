//
//  FlickrImageCollectionViewCell.swift
//  FlickrImageSearch
//
//  Created by Dimitar Dimitrov on 4.09.19.
//  Copyright © 2019 Dimitar Dimitrov. All rights reserved.
//

import UIKit

class FlickrImageCollectionViewCell: UICollectionViewCell, ReusableView {

    @IBOutlet weak var imageView: UIImageView!

    /**
     TODO: Add cell states:
     Loading/Loaded/error
     */
    override func prepareForReuse() {
        super.prepareForReuse()

        imageView.image = nil // Use default image?
    }
}
