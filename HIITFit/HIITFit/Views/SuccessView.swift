//
//  SuccessView.swift
//  HIITFit
//
//  Created by Arunkumar on 31/05/25.
//

import Foundation
import SwiftUI


struct SuccessView: View {
    
    @Environment(\.dismiss) var dismiss

    @Binding var selectedTab: Int
    
    var body: some View {
        ZStack {
            VStack {
                 Spacer()
                Image(systemName: "hand.raised.fingers.spread.fill")
                    .resizedToFill(width: 80, height: 80)
                    .foregroundColor(.purple)
                Text("High Five!")
                    .font(.largeTitle).bold()
                Text("""
                  Good job completing all four exercises!
                  Remember tomorrow's another day.
                  So eat well and get some rest.
                  """)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.secondary)
                 Spacer()
                Button("Continue", action: {
                    selectedTab = 9
                    dismiss()
                })
                .padding()
            }
        }
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    SuccessView(selectedTab: .constant(3))
}
