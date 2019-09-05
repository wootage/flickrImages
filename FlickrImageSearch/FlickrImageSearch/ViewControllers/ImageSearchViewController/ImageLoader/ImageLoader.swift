//
//  ImageLoader.swift
//  FlickrImageSearch
//
//  Created by Dimitar Dimitrov on 5.09.19.
//  Copyright © 2019 Dimitar Dimitrov. All rights reserved.
//

import Foundation

class ImageLoader {

    typealias ImagesResponseHandler = (PhotosResponse) -> Void

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
