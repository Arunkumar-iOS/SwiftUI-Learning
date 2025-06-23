//
//  CardDetailView.swift
//  Cards
//
//  Created by Arunkumar on 23/06/25.
//

import Foundation
import SwiftUI

struct CardDetailView: View {
  // 1
  @EnvironmentObject var store: CardStore
  @Binding var card: Card

  var body: some View {
    // 2
    ZStack {
      card.backgroundColor
        ForEach($card.elements, id: \.id) { $element in
          CardElementView(element: element)
                .resizableView(transform: $element.transform)
            .frame(
              width: element.transform.size.width,
              height: element.transform.size.height)
        }

    }
  }
}

#Preview {
  @Previewable @State var card = initialCards[0]
  CardDetailView(card: $card)
    .environmentObject(CardStore(defaultData: true))
}
