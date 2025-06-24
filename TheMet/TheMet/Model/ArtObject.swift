//
//  Object.swift
//  TheMet
//
//  Created by Arunkumar on 23/06/25.
//

import Foundation
import SwiftUI

struct ArtObject: Codable, Hashable {
  let objectID: Int
  let title: String
  let creditLine: String
  let objectURL: String
  let isPublicDomain: Bool
  let primaryImageSmall: String
}

struct ObjectIDs: Codable {
  let total: Int
  let objectIDs: [Int]
}

