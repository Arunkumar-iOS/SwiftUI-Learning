//
//  GradientBackground.swift
//  HIITFit
//
//  Created by Arunkumar on 13/06/25.
//

import Foundation
import SwiftUI


struct GradientBackground: View {
    
    var gradient: Gradient {
      let color1 = Color.gradientTop
      let color2 = Color.gradientBottom
      let background = Color.background
      return Gradient(
        stops: [
          Gradient.Stop(color: color1, location: 0),
          Gradient.Stop(color: color2, location: 0.9),
          Gradient.Stop(color: background, location: 0.9),
          Gradient.Stop(color: background, location: 1)
        ])
    }


    var body: some View {
        LinearGradient(
            gradient: gradient,
            startPoint: .top,
            endPoint: .bottom)
        .ignoresSafeArea()
    }
}


#Preview(traits: .sizeThatFitsLayout) {
    GradientBackground()
}
