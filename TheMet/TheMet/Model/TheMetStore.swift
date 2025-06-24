//
//  TheMetStore.swift
//  TheMet
//
//  Created by Arunkumar on 23/06/25.
//

import Foundation
import SwiftUI

//This store is a source of truth, that drives the app.
class TheMetStore: ObservableObject {
    @Published var artObjects: [ArtObject] = []
    
    init() {
        #if DEBUG
        createDevData()
        #endif
    }
}
