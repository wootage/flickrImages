//
//  ImageLoaderWebServiceProtocol.swift
//  FlickrImageSearch
//
//  Created by Dimitar Dimitrov on 5.09.19.
//  Copyright © 2019 Dimitar Dimitrov. All rights reserved.
//

protocol ImageLoaderWebServiceProtocol {
    func getImages(searchText: String, page: Int, completion: @escaping ((PhotosResponse) -> Void))
}
