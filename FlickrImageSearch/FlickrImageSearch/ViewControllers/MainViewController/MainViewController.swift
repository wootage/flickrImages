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

        let apiClient = APIClient()
        let dataSource = ImageSearchCollectionViewDataSource()

        let searchViewController = ImageLoaderModuleConfigurator.getImageSearchViewController(apiClient: apiClient, dataSource: dataSource)

        present(searchViewController, animated: false, completion: nil)
    }
}
