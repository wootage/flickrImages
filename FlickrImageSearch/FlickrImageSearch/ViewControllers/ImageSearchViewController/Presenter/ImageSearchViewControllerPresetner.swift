//
//  ImageSearchViewControllerPresetner.swift
//  FlickrImageSearch
//
//  Created by Dimitar Dimitrov on 5.09.19.
//  Copyright © 2019 Dimitar Dimitrov. All rights reserved.
//

import Foundation

protocol ImageSearchViewControllerPresenterProtocol {
    var delegate: ImageSearchViewControllerPresenterDelegate? { get set }

    func newSearch(text: String)
    func loadNextPage()
}

protocol ImageSearchViewControllerPresenterDelegate: class {
    func didLoadNewData(flickrImages: [FlickrImageViewModel])
}

class ImageSearchViewControllerPresenter: ImageSearchViewControllerPresenterProtocol {

    private var interactor: ImageSearchViewControllerInteractorProtocol

    weak var delegate: ImageSearchViewControllerPresenterDelegate?

    init(interactor: ImageSearchViewControllerInteractorProtocol) {
        self.interactor = interactor

        self.interactor.delegate = self
    }

    func newSearch(text: String) {
        interactor.newSearch(text)
    }

    func loadNextPage() {
        interactor.loadNextPage()
    }
}

extension ImageSearchViewControllerPresenter: ImageSearchViewControllerInteractorDelegate {
    func didLoad(newImageData: [FlickrImage]) {

        let viewModels = newImageData.map { FlickrImageViewModel($0) }
        self.delegate?.didLoadNewData(flickrImages: viewModels)
    }
}
