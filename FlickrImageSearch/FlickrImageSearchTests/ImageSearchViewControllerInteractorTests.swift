//
//  ImageSearchViewControllerInteractorTests.swift
//  FlickrImageSearchTests
//
//  Created by Dimitar Dimitrov on 5.09.19.
//  Copyright © 2019 Dimitar Dimitrov. All rights reserved.
//

import XCTest
@testable import FlickrImageSearch

class ImageSearchViewControllerInteractorTests: XCTestCase {

    var interactor: ImageSearchViewControllerInteractor!
    fileprivate var presenter: MockPresenter!
    fileprivate var mockImageLoader: MockImageLoader!

    override func setUp() {

        mockImageLoader = MockImageLoader()
        interactor = ImageSearchViewControllerInteractor(imageLoader: mockImageLoader)

        presenter = MockPresenter(interactor: interactor)

        interactor.delegate = presenter
    }

    func testSuccessLoadNextPage() {

        // First page is 1, verify that the api call is correct
        presenter.loadNextPage()
        XCTAssertTrue(mockImageLoader.calledWithPage == 2)

        // After the api call passes it updates the page from the response (3 in that case)
        presenter.loadNextPage()
        XCTAssertTrue(mockImageLoader.calledWithPage == 4)
    }

    func testSuccessfullNewSearch() {

        presenter.newSearch(text: "testSearch")

        XCTAssertNotNil(mockImageLoader.calledWithTerm)
        XCTAssertTrue(mockImageLoader.calledWithTerm == "testSearch")
    }

    func testShouldNotDoubleCallNextPage() {

        mockImageLoader.testResponse = PhotosResponse(page: 3, pages: 2, perpage: 3, total: "1", photo: [])

        presenter.loadNextPage()
        XCTAssertTrue(mockImageLoader.calledWithPage == 2)

        presenter.loadNextPage()
        XCTAssertTrue(mockImageLoader.calledWithPage == 2)

    }

    func testItemsCountShouldBeUpdated() {

        let randomNumber = Int.random(in: 1...10)

        mockImageLoader.testResponse = PhotosResponse(page: 3,
                                                      pages: 2,
                                                      perpage: 3,
                                                      total: "1",
                                                      photo: Array(repeating: FlickrImage(), count: randomNumber)
            )

        presenter.loadNextPage()

        XCTAssertTrue(presenter.items.count == randomNumber)
    }
}

private extension FlickrImage {
    init() {
        self.init(id: "id",
                  owner: "owner",
                  secret: "secret",
                  server: "server",
                  farm: 1,
                  title: "title",
                  ispublic: 1,
                  isfriend: 0,
                  isfamily: 1)
    }
}

private class MockPresenter: ImageSearchViewControllerPresenterProtocol {

    // MARK: - Properties - Dependancy
    private var interactor: ImageSearchViewControllerInteractorProtocol
    var delegate: ImageSearchViewControllerPresenterDelegate?

    var items: [FlickrImage] = []

    // MARK: - Init
    init(interactor: ImageSearchViewControllerInteractorProtocol) {
        self.interactor = interactor

        self.interactor.delegate = self
    }

    func newSearch(text: String) {
        interactor.newSearch(text)
    }

    func loadNextPage() {
        interactor.loadNextPage()
    }

    //Interactor delegate
    func didLoad(newImageData: [FlickrImage]) {
        items = newImageData
    }
}

private class MockImageLoader: ImageLoaderProtocol {

    var calledWithTerm: String? = nil
    var calledWithPage: Int = 0

    var testResponse = PhotosResponse(page: 3, pages: 2, perpage: 3, total: "123", photo: [])

    func getImageData(_ searchText: String, page: Int, completion: @escaping ImagesResponseHandler) {
        calledWithTerm = searchText
        calledWithPage = page

        completion(testResponse)
    }
}
