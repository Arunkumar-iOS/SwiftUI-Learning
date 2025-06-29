//
//  PawsApp.swift
//  Paws
//
//  Created by Arunkumar on 28/06/25.
//

import SwiftUI
import SwiftData

@main
struct PawsApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: Pet.self)
        }
    }
}
