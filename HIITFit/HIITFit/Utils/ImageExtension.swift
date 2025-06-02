//
//  ImageExtension.swift
//  HIITFit
//
//  Created by Arunkumar on 31/05/25.
//

import Foundation
import SwiftUI


extension Image {
  /// Resize an image with fill aspect ratio and specified frame dimensions.
  ///   - parameters:
  ///     - width: Frame width.
  ///     - height: Frame height.
  func resizedToFill(width: CGFloat, height: CGFloat) -> some View {
    self // self refers current type that is image
      .resizable()
      .aspectRatio(contentMode: .fill)
      .frame(width: width, height: height)
  }
}

