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

    private lazy var flickrImageResponseHandler: FlickrImageResponseHandler = { [weak self] images in

        guard let self = self else { return }

        let viewModels = images.map { FlickrImageViewModel($0) }
        self.delegate?.didLoadNewData(flickrImages: viewModels)
    }

    init(interactor: ImageSearchViewControllerInteractorProtocol) {
        self.interactor = interactor
    }

    func newSearch(text: String) {
        interactor.newSearch(text, completion: flickrImageResponseHandler)
    }

    func loadNextPage() {
        interactor.loadNextPage(completion: flickrImageResponseHandler)
    }
}
