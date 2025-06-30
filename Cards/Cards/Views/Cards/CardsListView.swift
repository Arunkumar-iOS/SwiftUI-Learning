//
//  CardsListView.swift
//  Cards
//
//  Created by Arunkumar on 20/06/25.
//

import Foundation
import SwiftUI


struct CardsListView: View  {
    
    //Local state property
    @State private var isPresented = false
    @State private var selectedCard: Card?
    
    //Shared state property
    @EnvironmentObject var store: CardStore
    
    var body: some View {
        
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                ForEach(store.cards) { card in
                    CardThumbnail(card: card)
                        .contextMenu {
                            
                            Button(role: .destructive) {
                                store.removeCard(card)
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }

                        }
                        .onTapGesture {
                            selectedCard = card
                        }
                }
            }
        }
        //To show a full screen modal.
        .fullScreenCover(item: $selectedCard) { card in
            if let index = store.index(for: card) {
              SingleCardView(card: $store.cards[index])
            } else {
              fatalError("Unable to locate selected card")
            }

        }
    }
}


#Preview {
    CardsListView()
        .environmentObject(CardStore(defaultData: true))
}
