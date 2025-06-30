//
//  CardViewToolBar.swift
//  Cards
//
//  Created by Arunkumar on 22/06/25.
//

import Foundation
import SwiftUI


struct CardToolbar: ViewModifier {
    
    @Binding var card: Card
    @State private var stickerImage: UIImage?
    
    @Environment(\.dismiss) var dismiss
    
    @Binding var currentModal: ToolbarSelection?

    func body(content: Content) -> some View {
        content
        .toolbar {
            //Top Toolbar
            ToolbarItem(placement: .topBarTrailing) {
                Button("Done") {
                    dismiss()
                }
            }
            
            //Bottom Toolbar
            ToolbarItem(placement: .bottomBar) {
                BottomToolbar(card: $card, modal: $currentModal)
            }

        }
    
        .sheet(item: $currentModal) { item in
          switch item {
          case .stickerModal:
              StickerModal(stickerImage: $stickerImage)
                .onDisappear {
                  if let stickerImage = stickerImage {
                    card.addElement(uiImage: stickerImage)
                  }
                  stickerImage = nil
                }

          
          default:
            Text(String(describing: item))
          }
        }
    }
}


extension View {
    func cardToolbar(card: Binding<Card>,currentModal: Binding<ToolbarSelection?>) -> some View {
        self.modifier(CardToolbar(card: card, currentModal: currentModal))
    }
}

#Preview {
  Color.yellow
    .modifier(CardToolbar(
        card: .constant(Card()), currentModal: .constant(nil)))
}

