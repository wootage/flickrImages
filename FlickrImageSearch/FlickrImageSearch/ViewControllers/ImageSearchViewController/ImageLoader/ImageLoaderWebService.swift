//
//  ImageLoaderWebService.swift
//  FlickrImageSearch
//
//  Created by Dimitar Dimitrov on 5.09.19.
//  Copyright © 2019 Dimitar Dimitrov. All rights reserved.
//

class ImageLoaderWebService: ImageLoaderWebServiceProtocol {

    // MARK: - Properties - Dependancy
    private var apiClient: APIClientProtocol

    // MARK: - Init
    init(apiClient: APIClientProtocol) {
        self.apiClient = apiClient
    }

    // MARK: - Public
    func getImages(searchText: String, page: Int, completion: @escaping ((PhotosResponse) -> Void)) {
        let method = FlickrAPIMethods.search(searchText, page)

        apiClient.apiRequest(PhotosSearchResponse.self, flickrAPIMethod: method, method: .get, completion: { response in

            let photosResponse = response.photos
            completion(photosResponse)

        }, failure: { error in
            //TODO: Handle error
        })
    }
}
