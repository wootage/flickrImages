//
//  ImageSearchViewController.swift
//  FlickrImageSearch
//
//  Created by Dimitar Dimitrov on 5.09.19.
//  Copyright © 2019 Dimitar Dimitrov. All rights reserved.
//

import UIKit

private enum Constants {
    static let numberOfItemsOnRow: CGFloat = 3
    static let cellSpacing: CGFloat = 16
}

class ImageSearchViewController: UIViewController {

    // MARK: - Properties - Outlets
    @IBOutlet private weak var collectionView: UICollectionView!

    // MARK: - Properties - Dependancy
    private var dataSource: ImageSearchCollectionViewDataSource
    private var imageLoader: ImageLoader

    // MARK: - Init
    init(imageLoader: ImageLoader, dataSource: ImageSearchCollectionViewDataSource) {
        self.imageLoader = imageLoader
        self.dataSource = dataSource

        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.register(FlickrImageCollectionViewCell.self)
        collectionView.contentInset = UIEdgeInsets(top: 0,
                                                   left: Constants.cellSpacing,
                                                   bottom: 0,
                                                   right: Constants.cellSpacing)
        collectionView.dataSource = dataSource
        collectionView.delegate = self
    }

    // MARK: - Search loading
    private func newSearch(_ searchText: String) {

        // Reset the model state
        // TODO: bind the reloading with the view models
        dataSource.viewModels = []
        collectionView.reloadData()

        imageLoader.newSearch(searchText) { [weak self] viewModels in

            guard let self = self else { return }

            self.dataSource.viewModels = viewModels
            self.collectionView.reloadData()
        }
    }

    private func loadNextPage() {
        imageLoader.loadNextPage { viewModels in
            self.dataSource.viewModels.append(contentsOf: viewModels)

            //TODO: Load only the new images instead of reloading the whole collection view
            self.collectionView.reloadData()
        }
    }
}

// MARK: - UISearchBarDelegate
extension ImageSearchViewController: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text, !searchText.isEmpty else { return }

        searchBar.resignFirstResponder()
        newSearch(searchText)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension ImageSearchViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        // Collection view width - left/right content inset - cell spacing
        let collectionViewWidth = collectionView.frame.size.width - 2*Constants.cellSpacing - (Constants.numberOfItemsOnRow - 1)*Constants.cellSpacing

        let cellWidth = (collectionViewWidth / Constants.numberOfItemsOnRow)
        return CGSize(width: cellWidth, height: cellWidth)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 16, left: 0, bottom: 0, right: 0)
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if (indexPath.row == dataSource.viewModels.count - 1 ) {
            loadNextPage()
        }
    }
}
