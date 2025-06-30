//
//  Card.swift
//  Cards
//
//  Created by Arunkumar on 23/06/25.
//

import Foundation
import SwiftUI

struct Card: Identifiable {
    let id = UUID()
    var backgroundColor: Color = .yellow
    //Inside the card what kind of elements you are going to use.
    var elements: [CardElement] = []
    
    mutating func addElement(uiImage: UIImage) {
        let element = ImageElement(uiImage: uiImage)
        elements.append(element)
    }
    
    mutating func addElement(text: TextElement) {
      elements.append(text)
    }
    
    
    mutating func addElements(from transfer: [CustomTransfer]) {
      for element in transfer {
        if let text = element.text {
          addElement(text: TextElement(text: text))
        } else if let image = element.image {
          addElement(uiImage: image)
        }
      }
    }
    
    mutating func remove(_ element: CardElement) {
      if let index = element.index(in: elements) {
        elements.remove(at: index)
      }
    }


    
}
