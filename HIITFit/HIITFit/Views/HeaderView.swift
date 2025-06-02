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
                    let fill = index == selectedTab ? ".fill" : ""
                    Image(systemName: "\(index + 1).circle\(fill)") // 4
                        .onTapGesture {
                            print("Selected Index \(index)")
                            selectedTab = index
                        }
                }
            }
            .font(.title2)
        }
    }
}


#Preview(traits: .sizeThatFitsLayout) {
    HeaderView(selectedTab: .constant(0), titleText: "Squat")
}
