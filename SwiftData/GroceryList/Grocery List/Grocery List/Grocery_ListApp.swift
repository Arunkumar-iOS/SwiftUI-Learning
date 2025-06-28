//
//  Grocery_ListApp.swift
//  Grocery List
//
//  Created by Arunkumar on 28/06/25.
//

import SwiftUI
import SwiftData

@main
struct Grocery_ListApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
            //This creates a storage for GroceryModel. We already know Model Container is like a database where we can store data and retrieve it.
            // I am injecting to ContentView so all ancestor view can access this.
                .modelContainer(for: Item.self)
        }
    }
}
