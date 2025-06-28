//
//  WishListApp.swift
//  WishList
//
//  Created by Arunkumar on 26/06/25.
//

import SwiftUI
import SwiftData

@main
struct WishListApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
            //This creates a storage for Wish model. We already know Model Container is like a database where we can store data and retrieve it.
            // I am injecting to ContentView so all ancestor view can access this.
                .modelContainer(for: Wish.self)
        }
    }
}
