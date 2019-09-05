//
//  ImageSearchViewControllerPresetner.swift
//  FlickrImageSearch
//
//  Created by Dimitar Dimitrov on 5.09.19.
//  Copyright © 2019 Dimitar Dimitrov. All rights reserved.
//

import Foundation

/**
Should interact with the `interactor` and the view

 * tells interactor to load
 * tells the view to display

 */
protocol ImageSearchViewControllerPresenterProtocol {
    var delegate: ImageSearchViewControllerPresenterDelegate? { get set }

    func newSearch(text: String)
    func loadNextPage()
}

protocol ImageSearchViewControllerPresenterDelegate: class {
    func didLoadNewData(flickrImages: [FlickrImageViewModel])
}

class ImageSearchViewControllerPresenter: ImageSearchViewControllerPresenterProtocol {

    // MARK: - Properties - Dependancy
    private var interactor: ImageSearchViewControllerInteractorProtocol

    // MARK: - Properties - Delegates
    weak var delegate: ImageSearchViewControllerPresenterDelegate?

    // MARK: - Init
    init(interactor: ImageSearchViewControllerInteractorProtocol) {
        self.interactor = interactor

        self.interactor.delegate = self
    }

    // MARK: - Public
    func newSearch(text: String) {
        interactor.newSearch(text)
    }

    func loadNextPage() {
        interactor.loadNextPage()
    }
}

// MARK: - ImageSearchViewControllerInteractorDelegate
extension ImageSearchViewControllerPresenter: ImageSearchViewControllerInteractorDelegate {
    func didLoad(newImageData: [FlickrImage]) {

        let viewModels = newImageData.map { FlickrImageViewModel($0) }
        self.delegate?.didLoadNewData(flickrImages: viewModels)
    }
}
