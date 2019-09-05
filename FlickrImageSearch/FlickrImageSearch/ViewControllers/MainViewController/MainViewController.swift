//
//  MainViewController.swift
//  FlickrImageSearch
//
//  Created by Dimitar Dimitrov on 5.09.19.
//  Copyright © 2019 Dimitar Dimitrov. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        // Move all the initialization in router
        let webServiceProvider = ImageLoaderWebService(apiClient: APIClient())
        let imageLoader = ImageLoader(imageLoaderWebServiceProvider: webServiceProvider)
        let dataSource = ImageSearchCollectionViewDataSource()

        let searchViewController = ImageSearchViewController(imageLoader: imageLoader, dataSource: dataSource)
        present(searchViewController, animated: false, completion: nil)
    }
}
