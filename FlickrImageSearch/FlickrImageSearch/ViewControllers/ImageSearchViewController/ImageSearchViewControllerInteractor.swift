//
//  ImageSearchViewControllerInteractor.swift
//  FlickrImageSearch
//
//  Created by Dimitar Dimitrov on 5.09.19.
//  Copyright © 2019 Dimitar Dimitrov. All rights reserved.
//

import Foundation

typealias FlickrImageResponseHandler = ([FlickrImage]) -> Void

protocol ImageSearchViewControllerInteractorProtocol {
    func newSearch(_ text: String, completion: @escaping FlickrImageResponseHandler)
    func loadNextPage(completion: @escaping FlickrImageResponseHandler)
}

class ImageSearchViewControllerInteractor: ImageSearchViewControllerInteractorProtocol {

    // MARK: - Properties - Private
    private var currentPage: Int = 1
    private var availablePages: Int = 0
    private var searchText: String = ""

    private var imageLoader: ImageLoader

    // MARK: - Init
    init(imageLoader: ImageLoader) {
        self.imageLoader = imageLoader
    }

    // MARK: - Public
    func newSearch(_ text: String, completion: @escaping FlickrImageResponseHandler) {

        currentPage = 1
        availablePages = 0
        searchText = text

        loadImages(text: searchText, page: currentPage, completion: completion)
    }

    func loadNextPage(completion: @escaping FlickrImageResponseHandler) {

        loadImages(text: searchText, page: currentPage + 1, completion: completion)
    }

    private func loadImages(text: String, page: Int, completion: @escaping FlickrImageResponseHandler) {
        imageLoader.getImageData(text, page: page) { [weak self] photosResponse in

            guard let self = self else { return }

            self.currentPage = photosResponse.page
            self.availablePages = photosResponse.pages

            completion(photosResponse.photo)
        }
    }
}
