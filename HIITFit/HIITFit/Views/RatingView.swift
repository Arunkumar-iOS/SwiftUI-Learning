//
//  RatingView.swift
//  HIITFit
//
//  Created by Arunkumar on 30/05/25.
//

import Foundation
import SwiftUI


struct RatingView: View {
    var body: some View {
        HStack {
            ForEach(0..<6) { _ in
                Image(systemName: "waveform.path.ecg")
                    .font(.largeTitle)
                    .foregroundStyle(.gray)
            }
        }
        
    }
}

//Used to show only a particular view. Instead of loading all elements in view.
#Preview(traits: .sizeThatFitsLayout) {
    RatingView()
}
