//
//  APIClient.swift
//  FlickrImageSearch
//
//  Created by Dimitar Dimitrov on 4.09.19.
//  Copyright © 2019 Dimitar Dimitrov. All rights reserved.
//

import Foundation

protocol APIClientProtocol {
    func apiRequest<T: Codable>(_ dataType: T.Type,
                                flickrAPIMethod: FlickrAPIMethods,
                                method: HTTPMethod,
                                completion: ((T) -> Void)?,
                                failure: ((ResultError) -> Void)?)
}

final class APIClient: APIClientProtocol {

    private let session = URLSession(configuration: URLSessionConfiguration.default, delegate: nil, delegateQueue: nil)

    // The compiler cannot explicitly specialize a generic function, so we have to add `dataType: T.Type` in the signature
    func apiRequest<T: Codable>(_ dataType: T.Type,
                                            flickrAPIMethod: FlickrAPIMethods,
                                            method: HTTPMethod,
                                            completion: ((T) -> Void)?,
                                            failure: ((ResultError) -> Void)?) {

        guard let urlString = flickrAPIMethod.path,
            let composedUrl = URL(string: urlString) else {
                failure?(.general("Wrong url"))
                return
        }

        var request = URLRequest(url: composedUrl)
        request.httpMethod = method.rawValue

        let task = session.dataTask(with: request, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) -> Void in

            guard let data = data else {
                failure?(.general("Data missing"))
                return
            }

            do {
                let response = try JSONDecoder().decode(T.self, from: data)

                completion?(response)
            }
            catch (let error) {
                failure?(.general(error.localizedDescription))
            }
        })
        task.resume()
    }
}
