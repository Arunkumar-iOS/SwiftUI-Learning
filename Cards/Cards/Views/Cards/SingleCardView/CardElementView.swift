//
//  CardElementView.swift
//  Cards
//
//  Created by Arunkumar on 23/06/25.
//

import Foundation
import SwiftUI


struct CardElementView: View {
  let element: CardElement

  var body: some View {
    if let element = element as? ImageElement {
        ImageElementView(element: element)
          .clip()
          

    }
    if let element = element as? TextElement {
      TextElementView(element: element)
    }
  }
}


//ImageElement is adapted the CardElement protocol and added extra properties
struct ImageElementView: View {
  let element: ImageElement

  var body: some View {
    element.image
      .resizable()
      .aspectRatio(contentMode: .fit)

  }
}

//TextElement is adapted the CardElement protocol and added extra properties
struct TextElementView: View {
  let element: TextElement

  var body: some View {
    if !element.text.isEmpty {
      Text(element.text)
        .font(.custom(element.textFont, size: 200))
        .foregroundStyle(element.textColor)
        .scalableText()
    }
  }
}



#Preview {
    CardElementView(element: initialElements[0])
}


// 1
private extension ImageElementView {
  // The ViewBuilder attribute allows you to build up views and combine them into one.
  @ViewBuilder
  func clip() -> some View {
    // 3
    if let frameIndex = element.frameIndex {
      // 4
      let shape = Shapes.shapes[frameIndex]
      self
         .clipShape(shape)
         .contentShape(Ellipse())
    } else { self }
  }
}
