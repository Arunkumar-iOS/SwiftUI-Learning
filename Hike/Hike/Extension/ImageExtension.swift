//
//  ImageExtension.swift
//  Hike
//
//  Created by Arunkumar on 25/06/25.
//

import Foundation
import SwiftUI


extension Image {
    
    func resize() -> some View {
        self
            .resizable()
            .scaledToFit()
    }
}
