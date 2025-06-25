//
//  URLComponentsExtension.swift
//  TheMet
//
//  Created by Arunkumar on 25/06/25.
//

import Foundation


extension URLComponents {

    mutating func setQueryItems(with items: [String: String?]) {
        self.queryItems = items.map { key, value in
            URLQueryItem(name: key, value: value)
        }
    }
}
