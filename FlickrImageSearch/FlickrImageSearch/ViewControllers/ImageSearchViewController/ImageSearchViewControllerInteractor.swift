//
//  ImageSearchViewControllerInteractor.swift
//  FlickrImageSearch
//
//  Created by Dimitar Dimitrov on 5.09.19.
//  Copyright © 2019 Dimitar Dimitrov. All rights reserved.
//

import Foundation

/**
 Should interact with the `presenter` and the image loader

 * Communicate with the image loader to load the pages
 * Update presenter's models
 * Count pages
 */
protocol ImageSearchViewControllerInteractorProtocol {
    var delegate: ImageSearchViewControllerInteractorDelegate? { get set }

    func newSearch(_ text: String)
    func loadNextPage()
}

protocol ImageSearchViewControllerInteractorDelegate: class {
    func didLoad(newImageData: [FlickrImage])
}

class ImageSearchViewControllerInteractor: ImageSearchViewControllerInteractorProtocol {

    // MARK: - Properties - Private
    private var currentPage: Int = 1
    private var availablePages: Int = 0
    private var pageSize: Int = 0
    private var totalItems: Int = 0
    private var searchText: String = ""

    private var shouldLoadNext: Bool {
        return totalItems < currentPage * pageSize
    }

    // MARK: - Properties - Dependancy
    private var imageLoader: ImageLoaderProtocol

    // MARK: - Properties - Delegates
    weak var delegate: ImageSearchViewControllerInteractorDelegate?

    // MARK: - Init
    init(imageLoader: ImageLoaderProtocol) {
        self.imageLoader = imageLoader
    }

    // MARK: - Public
    func newSearch(_ text: String) {

        currentPage = 1
        availablePages = 0
        searchText = text

        loadImages(text: searchText, page: currentPage)
    }

    func loadNextPage() {

        guard !shouldLoadNext else { return }

        loadImages(text: searchText, page: currentPage + 1)
    }

    // MARK: - Misc. - Private
    private func loadImages(text: String, page: Int) {

        imageLoader.getImageData(text, page: page) { [weak self] photosResponse in

            guard let self = self else { return }

            self.currentPage = photosResponse.page
            self.availablePages = photosResponse.pages
            self.pageSize = photosResponse.perpage
            self.totalItems = photosResponse.totalItems

            self.delegate?.didLoad(newImageData: photosResponse.photo)
        }
    }
}
