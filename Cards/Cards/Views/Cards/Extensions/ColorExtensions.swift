//
//  ColorExtensions.swift
//  Cards
//
//  Created by Arunkumar on 22/06/25.
//

import Foundation
import SwiftUI

extension Color {
    static let colors: [Color] = [
        .green, .red, .blue, .gray, .yellow, .pink, .orange, .purple
    ]
    
    
    static func random() -> Color {
        colors.randomElement() ?? .black
    }
    
}
