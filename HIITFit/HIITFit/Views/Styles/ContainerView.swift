//
//  ContainerView.swift
//  HIITFit
//
//  Created by Arunkumar on 13/06/25.
//

import Foundation
import SwiftUI



struct ContainerView<Content: View>: View {
    
    var content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    
    var body: some View {
        
        ZStack {
            RoundedRectangle(cornerRadius: 25.0)
                .foregroundStyle(Color.background)
            VStack {
                Spacer()
                Rectangle()
                    .frame(height: 25)
                    .foregroundStyle(Color.background)
            }
            content
        }
        .containerRelativeFrame(.vertical) { length, _ in
            length * 0.8
        }

    }
    
}


#Preview(traits: .sizeThatFitsLayout) {
  
  ContainerView {
    VStack {
      RaisedButton(buttonText: "Hello World") {}
        .padding(50)
      Button("Tap me!") {}
        .buttonStyle(EmbossedButtonStyle(buttonShape: .circle))
        .padding(.top, 30)
    }
  }
  .padding(50)
}
