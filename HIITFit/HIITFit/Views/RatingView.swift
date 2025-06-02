//
//  RatingView.swift
//  HIITFit
//
//  Created by Arunkumar on 30/05/25.
//

import Foundation
import SwiftUI


struct RatingView: View {
    
    @Binding var rating: Int
    
    let maximumRating = 5
    
    var onColor: Color = .red
    var offColor: Color = .gray
    
    var body: some View {
        HStack {
            
            ForEach(0..<maximumRating, id: \.self) { index in
                Image(systemName: "waveform.path.ecg")
                    .font(.largeTitle)
                    .foregroundColor(index <= rating ? onColor : offColor)
                    .onTapGesture {
                        rating = index
                    }
            }
        }
        
    }
}

//Used to show only a particular view. Instead of loading all elements in view.
#Preview(traits: .sizeThatFitsLayout) {
    RatingView(rating: .constant(3))
}
