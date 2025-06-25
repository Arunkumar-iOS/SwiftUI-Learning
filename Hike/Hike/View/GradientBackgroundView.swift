//
//  GradientBackgroundView.swift
//  Hike
//
//  Created by Arunkumar on 24/06/25.
//

import SwiftUI

struct GradientBackgroundView: View {
    
    var backgroundGradientColor : [Color]  {
        [Color.colorGreenLight, Color.colorGreenMedium]
    }
    
    var body: some View {
        
        //Depth
        ZStack {
            Color.colorGreenDark
                .cornerRadius(40)
                .offset(y: 12)
            
            //Light
            Color.colorGreenLight
                .cornerRadius(40)
                .offset(y: 3)
            
            //actual background
            LinearGradient(colors: backgroundGradientColor,
                           startPoint: .top,
                           endPoint: .bottom
            )
            .cornerRadius(40)
        }
        
    }
}

#Preview {
    GradientBackgroundView()
        .padding()
}
