//
//  ImageLoader.swift
//  FlickrImageSearch
//
//  Created by Dimitar Dimitrov on 5.09.19.
//  Copyright © 2019 Dimitar Dimitrov. All rights reserved.
//

import Foundation

typealias ImagesResponseHandler = (PhotosResponse) -> Void

protocol ImageLoaderProtocol {
    func getImageData(_ searchText: String, page: Int, completion: @escaping ImagesResponseHandler)
}

/**
Load image response from a service
 */
class ImageLoader: ImageLoaderProtocol {

    // MARK: - Properties - Dependancy
    private var imageLoaderWebServiceProvider: ImageLoaderWebServiceProtocol

    // MARK: - Init
    init(imageLoaderWebServiceProvider: ImageLoaderWebServiceProtocol) {
        self.imageLoaderWebServiceProvider = imageLoaderWebServiceProvider
    }

    // MARK: - Misc. - Public
    func getImageData(_ searchText: String, page: Int, completion: @escaping ImagesResponseHandler) {

        imageLoaderWebServiceProvider.getImages(searchText: searchText, page: page) { photosResponse in

            DispatchQueue.main.async {
                completion(photosResponse)
            }
        }
    }
}
