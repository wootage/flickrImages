//
//  PhotosResponseTests.swift
//  FlickrImageSearchTests
//
//  Created by Dimitar Dimitrov on 5.09.19.
//  Copyright © 2019 Dimitar Dimitrov. All rights reserved.
//

import XCTest
@testable import FlickrImageSearch

class PhotosResponseTests: XCTestCase {

    func testPhotosResponseShouldHaveCorrectTotalItemsCount() {

        let photosResponse = PhotosResponse(page: 3,
                                            pages: 10,
                                            perpage: 4,
                                            total: "22",
                                            photo: [])

        XCTAssertTrue(photosResponse.totalItems == 22)
    }

    func testPhotosResponseShouldHaveZeroTotalItemsCount() {

        let photosResponse = PhotosResponse(page: 3,
                                            pages: 10,
                                            perpage: 4,
                                            total: "",
                                            photo: [])

        XCTAssertTrue(photosResponse.totalItems == 0)

        let photosResponseString = PhotosResponse(page: 3,
                                            pages: 10,
                                            perpage: 4,
                                            total: "asd",
                                            photo: [])

        XCTAssertTrue(photosResponseString.totalItems == 0)
    }
}
