//
//  PhotosSearchResponse.swift
//  FlickrImageSearch
//
//  Created by Dimitar Dimitrov on 4.09.19.
//  Copyright © 2019 Dimitar Dimitrov. All rights reserved.
//

import Foundation

struct PhotosSearchResponse: Codable {
    let photos: PhotosResponse
    let stat: String
}
