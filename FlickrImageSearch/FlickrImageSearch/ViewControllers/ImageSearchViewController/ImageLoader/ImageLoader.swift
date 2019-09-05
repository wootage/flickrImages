//
//  ImageLoader.swift
//  FlickrImageSearch
//
//  Created by Dimitar Dimitrov on 5.09.19.
//  Copyright © 2019 Dimitar Dimitrov. All rights reserved.
//

import Foundation

class ImageLoader {

    typealias ImagesResponseHandler = ([FlickrImageViewModel]) -> Void

    // MARK: - Properties - Private
    private var currentPage: Int = 1
    private var availablePages: Int = 0
    private var searchText: String = ""

    // MARK: - Properties - Dependancy
    private var imageLoaderWebServiceProvider: ImageLoaderWebServiceProtocol

    // MARK: - Init
    init(imageLoaderWebServiceProvider: ImageLoaderWebServiceProtocol) {
        self.imageLoaderWebServiceProvider = imageLoaderWebServiceProvider
    }

    // MARK: - Public
    func newSearch(_ text: String, completion: @escaping ImagesResponseHandler) {

        currentPage = 1
        availablePages = 0
        searchText = text

        getImageData(searchText, page: currentPage, completion: completion)
    }

    func loadNextPage(completion: @escaping ImagesResponseHandler) {

        getImageData(searchText, page: currentPage + 1, completion: completion)
    }

    // MARK: - Misc. - Private
    private func getImageData(_ searchText: String, page: Int, completion: @escaping ImagesResponseHandler) {

        imageLoaderWebServiceProvider.getImages(searchText: searchText, page: page) { [weak self] photosResponse in
            guard let self = self else { return }

            self.searchText = searchText
            self.currentPage = photosResponse.page
            self.availablePages = photosResponse.pages

            let photoViewModels = photosResponse.photo.map { FlickrImageViewModel($0) }

            DispatchQueue.main.async {
                completion(photoViewModels)
            }
        }
    }
}
