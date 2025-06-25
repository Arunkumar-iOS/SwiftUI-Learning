//
//  CustomCircleView.swift
//  Hike
//
//  Created by Arunkumar on 25/06/25.
//

import Foundation
import SwiftUI


struct CustomCircleView: View {
    
    @State private var isAnimateGradient: Bool = false
    
    var circleGradientColor : [Color]  {
        [Color.colorIndigoMedium, Color.colorSalmonLight]
    }
    
    
    var body: some View {
        Circle()
            .fill(
                LinearGradient(colors: circleGradientColor, startPoint: isAnimateGradient ?
                    .topLeading : .bottomLeading,
                               endPoint: isAnimateGradient ? .bottomTrailing : .topTrailing)
            )
            .frame(maxWidth: 256, maxHeight: 256)
            .onAppear {
                withAnimation(.linear(duration: 3.0).repeatForever(autoreverses: true)) {
                    isAnimateGradient.toggle()
                }
            }
    }
}


#Preview {
    CustomCircleView()
}
