//
//  FlickrImageViewModelTests.swift
//  FlickrImageSearchTests
//
//  Created by Dimitar Dimitrov on 5.09.19.
//  Copyright © 2019 Dimitar Dimitrov. All rights reserved.
//

import XCTest
@testable import FlickrImageSearch

class FlickrImageViewModelTests: XCTestCase {

    func testImageViewModelShouldGenerateCorrectImageURL() {

        let flickrImage = FlickrImage(id: "mockID",
                                      owner: "random",
                                      secret: "mockSecret",
                                      server: "mockServer",
                                      farm: 123,
                                      title: "title",
                                      ispublic: 1,
                                      isfriend: 1,
                                      isfamily: 1)

        let viewModel = FlickrImageViewModel(flickrImage)

        XCTAssertTrue(viewModel.imageStringURL == "https://farm123.static.flickr.com/mockServer/mockID_mockSecret.jpg")
    }
}
