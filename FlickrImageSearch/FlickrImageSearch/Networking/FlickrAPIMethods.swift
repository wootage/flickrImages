//
//  FlickrAPIMethods.swift
//  FlickrImageSearch
//
//  Created by Dimitar Dimitrov on 5.09.19.
//  Copyright © 2019 Dimitar Dimitrov. All rights reserved.
//

import Foundation

enum FlickrAPIMethods {
    fileprivate static let base = "https://api.flickr.com/services/rest/"
    fileprivate static let apiKey = "3e7cc266ae2b0e0d78e279ce8e361736"

    case search(String, Int)
}

extension FlickrAPIMethods {

    var path: String? {
        switch self {
        case .search(let searchText, let page):

            guard let escapedSearchString = searchText.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else { return nil }

            // URL composition is a bit long, probably can be optimized
            let upToApiKey = FlickrAPIMethods.base + "?method=flickr.photos.search&api_key=" + FlickrAPIMethods.apiKey
            return upToApiKey + "&format=json&nojsoncallback=1&safe_search=1&page=" + "\(page)" + "&text=" + escapedSearchString
        }
    }
}
