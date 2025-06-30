//
//  BottomToolbar.swift
//  Cards
//
//  Created by Arunkumar on 20/06/25.
//

import Foundation
import SwiftUI

struct ToolbarButton: View {
    
    private let modalButton: [
        ToolbarSelection: (text: String, imageName: String)
    ] = [
        .photoModal: ("Photos", "photo"),
        .frameModal: ("Frames", "square.on.circle"),
        .stickerModal: ("Stickers", "heart.circle"),
        .textModal: ("Text", "textformat")
    ]
    
    let modal: ToolbarSelection
    
    var body: some View {
      if let text = modalButton[modal]?.text,
        let imageName = modalButton[modal]?.imageName {
      VStack {
        Image(systemName: imageName)
          .font(.largeTitle)
          
        Text(text)
      }
      .padding(.top)
      }
    }

}


struct BottomToolbar: View {
  @Binding var card: Card
  @Binding var modal: ToolbarSelection?

  var body: some View {
    HStack {
      ForEach(ToolbarSelection.allCases) { selection in
        switch selection {
        //BottomToolbar now owns the photo picker view.
        case .photoModal:
          Button {
          } label: {
            PhotosModal(card: $card)
          }
        default:
          Button {
            modal = selection
          } label: {
            ToolbarButton(modal: selection)
          }
        }
      }
    }
  }
}


#Preview {
    BottomToolbar(card: .constant(Card()), modal: .constant(.photoModal))
}

