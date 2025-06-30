//
//  PhotosModal.swift
//  Cards
//
//  Created by Arunkumar on 29/06/25.
//

import SwiftUI
//This framework used to load a photo from mobile photo gallery.
import PhotosUI

struct PhotosModal: View {
  @Binding var card: Card
  // 1
  @State private var selectedItems: [PhotosPickerItem] = []

    var body: some View {
        // 2
        PhotosPicker(
            // 3
            selection: $selectedItems,
            // 4
            matching: .images) {
                // 5
                ToolbarButton(modal: .photoModal)
                
                    .onChange(of: selectedItems) { _, items in
                        for item in items {
                            //This function converts the photo image into data and gives result as Result type
                            item.loadTransferable(type: Data.self) { result in
                                //You already know that if you want to call the async operation you should use Task{}
                              Task {
                                  switch result {
                                  case .success(let data):
                                    if let data,
                                      let uiImage = UIImage(data: data) {
                                        
                                        await MainActor.run {
                                          card.addElement(uiImage: uiImage)
                                        }
                                    }
                                  case .failure(let failure):
                                    fatalError("Image transfer failed: \(failure)")
                                  }

                              }
                            }

                                
                            }
                                selectedItems = []
                            }
                            
                        }
                    }
            }



#Preview {
    PhotosModal(card: .constant(Card.init()))
}
