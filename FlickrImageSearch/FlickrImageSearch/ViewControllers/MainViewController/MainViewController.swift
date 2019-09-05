//
//  MainViewController.swift
//  FlickrImageSearch
//
//  Created by Dimitar Dimitrov on 5.09.19.
//  Copyright © 2019 Dimitar Dimitrov. All rights reserved.
//

import UIKit

/**
The sole purpose of this view controller is to instantiate the first view controller that has to be displayed

 * show login screen
 * extend the splash screen with some animation (if additional api calls/ calculations should be done in advance)
 * Potentially can be removed (if not needed) and set the initial view controller in the app delegate

 */
class MainViewController: UIViewController {

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        let apiClient = APIClient()
        let dataSource = ImageSearchCollectionViewDataSource()

        let searchViewController = ImageLoaderModuleConfigurator.getImageSearchViewController(apiClient: apiClient, dataSource: dataSource)

        present(searchViewController, animated: false, completion: nil)
    }
}
