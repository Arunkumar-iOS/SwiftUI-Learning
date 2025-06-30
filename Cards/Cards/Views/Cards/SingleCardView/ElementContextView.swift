//
//  ElementContextView.swift
//  Cards
//
//  Created by Arunkumar on 30/06/25.
//

import Foundation
import SwiftUI

struct ElementContextMenu: ViewModifier {
    @Binding var card: Card
    @Binding var element: CardElement
    
    func body(content: Content) -> some View {
        content
        // When you long press the element(image or text), It opens like a menu option bottom of the element.
        //This modifier is used to copy and paste element from this application to another application (like copy to notes).
            .contextMenu {
                Button {
                    if let element = element as? TextElement {
                        UIPasteboard.general.string = element.text
                    } else if let element = element as? ImageElement,
                              let image = element.uiImage {
                        UIPasteboard.general.image = image
                    }
                } label: {
                    Label("Copy", systemImage: "doc.on.doc")
                }

                //Used to remove the card element from the app.
                Button(role: .destructive) {
                  card.remove(element)
                } label: {
                  Label("Delete", systemImage: "trash")
                }

            }
        
    }
}

extension View {
  func elementContextMenu(
    card: Binding<Card>,
    element: Binding<CardElement>
  ) -> some View {
    modifier(ElementContextMenu(
      card: card,
      element: element))
  }
}
