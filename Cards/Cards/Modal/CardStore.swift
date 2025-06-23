//
//  CardStore.swift
//  Cards
//
//  Created by Arunkumar on 23/06/25.
//

import Foundation
import SwiftUI


class CardStore: ObservableObject {
    @Published var cards: [Card] = []
    
    init(defaultData: Bool = false) {
      if defaultData {
        cards = initialCards
      }
    }
    
    //To get the current card index
    func index(for card: Card) -> Int? {
      cards.firstIndex { $0.id == card.id }
    }

}
