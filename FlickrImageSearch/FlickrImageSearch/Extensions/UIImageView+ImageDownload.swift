//
//  UIImageView+ImageDownload.swift
//  FlickrImageSearch
//
//  Created by Dimitar Dimitrov on 5.09.19.
//  Copyright © 2019 Dimitar Dimitrov. All rights reserved.
//

import UIKit

extension UIImageView {
    func loadImage(stringURL: String) {

        guard let imageURL = URL(string: stringURL) else { return }

        // It's not great practice to use `shared` instance directly because it's hard to test
        // Better approach would be to create dedicated class to maintain the shared instance and inject it afterworks using protocol
        let cache = URLCache.shared
        let request = URLRequest(url: imageURL)

        DispatchQueue.global(qos: .userInitiated).async { [weak self] in

            guard let self = self else { return }

            if let data = cache.cachedResponse(for: request)?.data,
                let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.image = image
                }
            }
            else {

                URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
                    guard let data = data,
                        let response = response,
                        let image = UIImage(data: data) else { return }

                    let cachedData = CachedURLResponse(response: response, data: data)
                    cache.storeCachedResponse(cachedData, for: request)

                    DispatchQueue.main.async {
                        self.image = image
                    }
                }).resume()
            }
        }
    }
}
