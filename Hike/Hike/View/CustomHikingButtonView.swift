//
//  CustomHikingButtonView.swift
//  Hike
//
//  Created by Arunkumar on 25/06/25.
//

import SwiftUI

struct CustomHikingButtonView: View {
    var body: some View {
       
        Button {
            print("Hiking button tapped")
        } label: {
            ZStack {
                Circle()
                    .fill(LinearGradient(colors: [Color.colorGreenLight, Color.colorGreenMedium], startPoint: .top, endPoint: .bottom))
                    .frame(width: 60, height: 60)
                    .overlay(
                        Circle()
                            .stroke(Color.gray, lineWidth: 2)
                    )
                
                Image(systemName: "figure.hiking")
                    .resize()
                    .foregroundStyle(.colorGrayLight)
                    .frame(width: 40, height: 40)
            }
        }
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    CustomHikingButtonView()
}
