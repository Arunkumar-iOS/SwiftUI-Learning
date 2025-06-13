//
//  HeaderView.swift
//  HIITFit
//
//  Created by Arunkumar on 30/05/25.
//

import SwiftUI


struct HeaderView: View {
    
    @Binding var selectedTab: Int
    
    let titleText: String
    
    var body: some View {
        VStack {
            Text(titleText)
                .font(.largeTitle)
            HStack {
                ForEach(Exercise.exercises.indices, id: \.self) { index in  // 3
                    //To make a image to fill, you must check the selectedTap index
                    
                    ZStack {
                        // Outer circle (ring effect)
                        Circle()
                            .fill(Color.white.opacity(0.3))
                            .frame(width: 28, height: 28)
                            .opacity(index == selectedTab ? 0.7 : 0.0)
                        // Inner dot
                        Circle()
                            .fill(Color.white)
                            .frame(width: 12, height: 12)
                    }
                    
                    
                    /*
                    let fill = index == selectedTab ? ".fill" : ""
                    Image(systemName: "circle\(fill)")
                        .foregroundStyle(.white)
                        .onTapGesture {
                            print("Selected Index \(index)")
                            selectedTab = index
                        }
                     */
                }
            }
            .font(.title2)
            
        }
        .containerRelativeFrame(.vertical) { length, _ in
          length * 0.2
        }

    }
}


#Preview(traits: .sizeThatFitsLayout) {
    HeaderView(selectedTab: .constant(0), titleText: "Squat")
}
