//
//  FlickrImageViewModel.swift
//  FlickrImageSearch
//
//  Created by Dimitar Dimitrov on 4.09.19.
//  Copyright © 2019 Dimitar Dimitrov. All rights reserved.
//

import Foundation

struct FlickrImageViewModel {

    let imageStringURL: String

    init(_ flickrImage: FlickrImage) {

        let flickrImageString = "https://farm\(flickrImage.farm).static.flickr.com/\(flickrImage.server)/\(flickrImage.id)_\(flickrImage.secret).jpg"

        imageStringURL = flickrImageString
    }
}
