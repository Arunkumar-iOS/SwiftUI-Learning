//
//  CardView.swift
//  Hike
//
//  Created by Arunkumar on 24/06/25.
//

import SwiftUI

struct CardView: View {
    
    var circleGradientColor : [Color]  {
        [Color.colorIndigoMedium, Color.colorSalmonLight]
    }
    
    var body: some View {
       
        ZStack {
            GradientBackgroundView()
            
            VStack {
                CardHeaderView()
                
                ZStack {
                    Circle()
                        .fill(
                            LinearGradient(colors: circleGradientColor, startPoint: .topLeading, endPoint: .bottomTrailing)
                        )
                        .frame(maxWidth: 256, maxHeight: 256)
                    
                    // Image will be top of all
                    Image("image-1")
                        .resize()
                    
                }
            }
            
        }
        .frame(width: 320, height: 570)
    }
}

#Preview {
    CardView()
}
