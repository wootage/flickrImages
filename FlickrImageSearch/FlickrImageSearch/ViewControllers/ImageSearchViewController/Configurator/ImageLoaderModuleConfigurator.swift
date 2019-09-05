//
//  ImageLoaderModuleConfigurator.swift
//  FlickrImageSearch
//
//  Created by Dimitar Dimitrov on 5.09.19.
//  Copyright © 2019 Dimitar Dimitrov. All rights reserved.
//

class ImageLoaderModuleConfigurator {
    static func getImageSearchViewController(apiClient: APIClientProtocol,
                                             dataSource: ImageSearchCollectionViewDataSource) -> ImageSearchViewController {

        let webServiceProvider = ImageLoaderWebService(apiClient: apiClient)
        let imageLoader = ImageLoader(imageLoaderWebServiceProvider: webServiceProvider)

        let interactor = ImageSearchViewControllerInteractor(imageLoader: imageLoader)
        let presenter = ImageSearchViewControllerPresenter(interactor: interactor)

        let searchViewController = ImageSearchViewController(presenter: presenter, dataSource: dataSource)

        return searchViewController
    }
}
