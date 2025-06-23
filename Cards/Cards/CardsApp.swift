//
//  CardsApp.swift
//  Cards
//
//  Created by Arunkumar on 20/06/25.
//

import SwiftUI

@main
struct CardsApp: App {
    
    @StateObject var cardStore = CardStore(defaultData: true)
    
    var body: some Scene {
        WindowGroup {
            CardsListView()
                .environmentObject(cardStore)
        }
    }
}
