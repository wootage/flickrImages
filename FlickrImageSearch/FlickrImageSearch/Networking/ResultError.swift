//
//  ResultError.swift
//  FlickrImageSearch
//
//  Created by Dimitar Dimitrov on 5.09.19.
//  Copyright © 2019 Dimitar Dimitrov. All rights reserved.
//

enum ResultError: Error {
    case general(String)
    case specific(Int)
}
