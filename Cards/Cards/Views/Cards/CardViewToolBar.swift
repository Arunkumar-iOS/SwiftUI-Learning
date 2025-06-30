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
    
    
    //This is a popup menu
    var menu: some View {
        // 1
        Menu {
            Button {
                //Check paste board contains whether image or text and do appropriate things.
                if UIPasteboard.general.hasImages {
                    if let images = UIPasteboard.general.images {
                        for image in images {
                            card.addElement(uiImage: image)
                        }
                    }
                } else if UIPasteboard.general.hasStrings {
                    if let strings = UIPasteboard.general.strings {
                        for text in strings {
                            card.addElement(text: TextElement(text: text))
                        }
                    }
                }
                
            } label: {
                Label("Paste", systemImage: "doc.on.clipboard")
            }
            // 2
            .disabled(!UIPasteboard.general.hasImages
                      && !UIPasteboard.general.hasStrings)
        } label: {
            Label("Add", systemImage: "ellipsis.circle")
        }
    }


    func body(content: Content) -> some View {
        content
        .toolbar {
            //Top Toolbar
            ToolbarItem(placement: .topBarTrailing) {
                
                HStack {
                    //This button actually holds the menu button.
                    menu
                    
                    Button("Done") {
                        dismiss()
                    }
                }
                
               
                
                //This copy and past button used to copy element from another application and will paste here. If you click copy in safri while you are in spilt screen the item will be added to the paste board.
                //ToolbarItem(placement: .topBarTrailing) {
                  
               // }
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

