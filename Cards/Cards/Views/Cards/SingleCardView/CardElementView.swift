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
