//
//  SingleCardView.swift
//  Cards
//
//  Created by Arunkumar on 20/06/25.
//

import Foundation
import SwiftUI


struct SingleCardView: View  {
    
    @State private var currentModal: ToolbarSelection?
    
    //View Property
    var content: some View {
        ZStack {
            //If you want to add view modifier for multiple views together, you can use Group and add 2 views.
            Group {
                Capsule()
                    .foregroundStyle(.yellow)
                Text("Resize Me!")
                    .fontWeight(.bold)
                    .font(.system(size: 500))
                    .minimumScaleFactor(0.01)
                    .lineLimit(1)
            }
            .resizableView()
            
            Circle()
                .resizableView()
                .offset(CGSize(width: 50, height: 200))
        }
    }

    
    var body: some View {
        NavigationStack {
            content
                .cardToolbar(currentModal: $currentModal)

        }
        
    }
    
}


#Preview {
    SingleCardView()
}
