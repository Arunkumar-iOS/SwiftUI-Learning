//
//  CardHeaderView.swift
//  Hike
//
//  Created by Arunkumar on 24/06/25.
//

import SwiftUI

struct CardHeaderView: View {
    
    var title: some View {
        Text("Hiking")
            .font(.system(size: 52))
            .fontWeight(.black)
            .foregroundStyle(
                LinearGradient(
                    colors: [
                        Color.colorGrayLight,
                        Color.colorGrayMedium
                    ],
                    startPoint: .top,
                    endPoint: .bottom)
            )
    }
    
    var subTitle: some View {
        Text("Fun and enjoyable outdoor activity for friends and families")
            .multilineTextAlignment(.leading)
            .italic()
            .foregroundStyle(.colorGrayMedium)
    }
    
    var body: some View {
        
        VStack(alignment: .leading) {
            HStack() {
                title
                Spacer()
                CustomHikingButtonView()
            }
            subTitle
        }
        .padding(.horizontal, 30)
        
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    CardHeaderView()
        .padding(.horizontal)
}
