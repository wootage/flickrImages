//
//  ImageSearchCollectionViewDataSource.swift
//  FlickrImageSearch
//
//  Created by Dimitar Dimitrov on 5.09.19.
//  Copyright © 2019 Dimitar Dimitrov. All rights reserved.
//

import UIKit

class ImageSearchCollectionViewDataSource: NSObject, UICollectionViewDataSource {

    var viewModels: [FlickrImageViewModel] = []

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModels.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell: FlickrImageCollectionViewCell = collectionView.dequeueCell(for: indexPath)

        cell.backgroundColor = UIColor.lightGray

        let currentModel = viewModels[indexPath.row]

        cell.imageView.loadImage(stringURL: currentModel.imageStringURL)

        return cell
    }
}
