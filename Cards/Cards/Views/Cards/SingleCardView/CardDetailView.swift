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
          //When the user taps card background, you should clear the store selected element.
              .onTapGesture {
                  store.selectedElement = nil
              }
          
          ForEach($card.elements, id: \.id) { $element in
              CardElementView(element: element)
              //This modifier is used to copy and paste from this app to other app.
                  .elementContextMenu(
                    card: $card,
                    element: $element)
                  .resizableView(transform: $element.transform)
                  .frame(
                    width: element.transform.size.width,
                    height: element.transform.size.height)
                  .onTapGesture {
                      store.selectedElement = element
                  }
                  .border(
                    Settings.borderColor,
                    width: isSelected(element) ? Settings.borderWidth : 0)
                  

          }
          
      }//: ZSTACK
      
      .onDisappear {
        store.selectedElement = nil
      }      
      
      //This modifier supports drag and drop from other apps like from safari.
      
    .dropDestination(for: CustomTransfer.self) { items, location in
      print(location)
      Task {
        await MainActor.run {
          card.addElements(from: items)
        }
      }
      return !items.isEmpty
    }

      
      //This one for Image alone. We have created a custom type so it won't needed.
      /*
    .dropDestination(for: Data.self) { receivedData, location in
      print(location)
      for data in receivedData {
        if let image = UIImage(data: data) {
          card.addElement(uiImage: image)
        }
      }
      return !receivedData.isEmpty
    } */

  }
    
    //Check whether selected element is current element
    func isSelected(_ element: CardElement) -> Bool {
      store.selectedElement?.id == element.id
    }

}

#Preview {
  @Previewable @State var card = initialCards[0]
  CardDetailView(card: $card)
    .environmentObject(CardStore(defaultData: true))
}



