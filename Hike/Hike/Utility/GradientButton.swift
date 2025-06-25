//
//  GradientButtonStyle.swift
//  Hike
//
//  Created by Arunkumar on 25/06/25.
//

import SwiftUI

struct GradientButtonStyle: ButtonStyle {
  
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(.vertical)
            .padding(.horizontal, 30)
            .background(
                LinearGradient(colors: [
                    .colorGrayLight,
                    .colorGrayMedium
                ], startPoint: .top, endPoint: .bottom)
            )
            .cornerRadius(30)
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
    }
}

//We can this as extension, so we can simply call this like .gradientButton
extension ButtonStyle where Self == GradientButtonStyle {
  static var gradientButton: GradientButtonStyle {
    .init()
  }
}
