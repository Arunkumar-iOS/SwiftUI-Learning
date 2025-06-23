//
//  TextExtension.swift
//  Cards
//
//  Created by Arunkumar on 23/06/25.
//

import Foundation
import SwiftUI

extension Text {
    //It will shrink based on the container size.
  func scalableText(font: Font = Font.system(size: 1000)) -> some View {
    self
      .font(font)
      .minimumScaleFactor(0.01)
      .lineLimit(1)
  }
}
