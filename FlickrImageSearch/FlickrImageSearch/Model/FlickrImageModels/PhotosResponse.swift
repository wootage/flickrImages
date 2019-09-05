//
//  PhotosResponse.swift
//  FlickrImageSearch
//
//  Created by Dimitar Dimitrov on 4.09.19.
//  Copyright © 2019 Dimitar Dimitrov. All rights reserved.
//

import Foundation

struct PhotosResponse: Codable {
    let page: Int
    let pages: Int
    let perpage: Int
    let total: String
    let photo: [FlickrImage]

    var totalItems: Int {
        return Int(total) ?? 0
    }
}
