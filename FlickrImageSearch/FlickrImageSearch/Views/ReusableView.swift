//
//  ReusableView.swift
//  FlickrImageSearch
//
//  Created by Dimitar Dimitrov on 5.09.19.
//  Copyright © 2019 Dimitar Dimitrov. All rights reserved.
//

public protocol ReusableView {
    static var reuseIdentifier: String { get }
}

extension ReusableView {

    public static var reuseIdentifier: String {
        return String(describing: self)
    }
}
