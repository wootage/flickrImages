//
//  FlickrImage.swift
//  FlickrImageSearch
//
//  Created by Dimitar Dimitrov on 4.09.19.
//  Copyright © 2019 Dimitar Dimitrov. All rights reserved.
//

import Foundation

struct FlickrImage: Codable {
    let id: String
    let owner: String
    let secret: String
    let server: String
    let farm: Int
    let title: String
    let ispublic: Int
    let isfriend: Int
    let isfamily: Int
}
