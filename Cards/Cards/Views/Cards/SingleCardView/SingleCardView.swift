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
    
    @Binding var card: Card
 /*
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
            //This view modifier takes care of gestures.
            .resizableView()
            
            Circle()
                .resizableView()
                .offset(CGSize(width: 50, height: 200))
        }
    }

  */
    
    //View property
    var content: some View {
        CardDetailView(card: $card)
    }
    
    var body: some View {
        NavigationStack {
            content
            //This holds the cards toolbar like top and bottom of cards screen.
                .cardToolbar(card: $card, currentModal: $currentModal)

        }
        
    }
    
}


#Preview {
    SingleCardView(card: .constant(initialCards[0]))
}
