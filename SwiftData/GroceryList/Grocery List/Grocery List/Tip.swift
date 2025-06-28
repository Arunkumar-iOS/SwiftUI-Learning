//
//  Tip.swift
//  Grocery List
//
//  Created by Arunkumar on 28/06/25.
//

import Foundation
import TipKit


struct AddButtonTip: Tip {
    
    var title: Text {
        Text("Tap to Add Item")
    }

    var message: Text? {
        Text("You can tap this button to add groceries to your list.")
    }

    var image: Image? {
        Image(systemName: "plus.circle.fill")
    }
}
