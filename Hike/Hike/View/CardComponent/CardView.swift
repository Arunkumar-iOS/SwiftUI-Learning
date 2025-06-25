//
//  CardView.swift
//  Hike
//
//  Created by Arunkumar on 24/06/25.
//

import SwiftUI

struct CardView: View {
    
    @State private var cardImageName: String = "image-1"
    @State private var randomNumber: Int = 1
    
    var circle: some View {
        ZStack {
            CustomCircleView()
            
            //add bubbleView
            BubbleView()
        }
    }
    
    //Check the old number is same as new number, if yes again change the number.
    func randomNumer() {
        var newRandomNumber: Int
        repeat {
            newRandomNumber = Int.random(in: 1...5)
        } while newRandomNumber == randomNumber
        
        randomNumber = newRandomNumber
        cardImageName = "image-\(randomNumber)"
    }
    
    var exploreButton: some View {
        Button {
            randomNumer()
        } label: {
            Text("Explore More")
                .font(.title2)
                .fontWeight(.heavy)
                .foregroundStyle(
                    LinearGradient(colors: [
                        .colorGreenLight,
                        .colorGreenMedium
                    ],
                       startPoint: .topLeading,
                       endPoint: .topTrailing)
                )
                .shadow(color: .black.opacity(0.25), radius: 0.25, x: 1, y: 2)
        }
        /*
         When you apply .padding() on the Button itself, it behaves just like contentEdgeInsets in UIKit:

         🔹 It adds spacing around the label container,
         🔹 Visually enlarges the button's background,
         🔹 And increases the tappable (hit) area.
         */
        .buttonStyle(.gradientButton)
    }
    
    var body: some View {
       
        ZStack {
            GradientBackgroundView()
            
            VStack {
                //MARK: - HEADER
                CardHeaderView()
                
                //MARK: - MIDDLE VIEW
                ZStack {
                    circle
                    // Image will be top of all
                    Image(cardImageName)
                        .resize()
                    
                }
                // MARK: - FOOTER
               exploreButton
            }
            
        }
        .frame(width: 320, height: 570)
    }
}

#Preview {
    CardView()
}
