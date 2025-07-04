//
//  Settings.swift
//  Cards
//
//  Created by Arunkumar on 22/06/25.
//

import Foundation
import SwiftUI

//Defining constant value like this is far far better.
enum Settings {
  static let cardSize =
    CGSize(width: 1300, height: 2000)
  static let thumbnailSize =
    CGSize(width: 150, height: 250)
  static let defaultElementSize =
    CGSize(width: 250, height: 180)
  static let borderColor: Color = .blue
  static let borderWidth: CGFloat = 5
}
