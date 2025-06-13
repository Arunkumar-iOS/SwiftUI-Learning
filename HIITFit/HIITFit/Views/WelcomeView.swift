//
//  WelcomeView.swift
//  HIITFit
//
//  Created by Arunkumar on 30/05/25.
//


import Foundation
import SwiftUI


struct WelcomeView: View {
    
    @State private var showHistory: Bool = false
    @Binding var selectedTab: Int
    @EnvironmentObject var historyStore: HistoryStore
    
    //Create a computed property for button
    var getStartedButton: some View {
      RaisedButton(buttonText: "Get Started") {
        selectedTab = 0
      }
      .padding()
    }
    
    var historyButton: some View {
        Button(
            action: {
                showHistory = true
            }, label: {
                Text("History")
                    .fontWeight(.bold)
                    .padding([.leading, .trailing], 5)
            })
        .padding(.bottom, 10)
        .buttonStyle(EmbossedButtonStyle())
    }


    
    var body: some View {
        ZStack {
            VStack {
                HeaderView(selectedTab: $selectedTab, titleText: "Welcome")
                    .padding(.bottom)
                Spacer()
                historyButton
                .sheet(isPresented: $showHistory) {
                    HistoryView(showHistory: $showHistory)
                }
                    .padding(.bottom)
                
            }
            VStack {
                HStack(alignment: .bottom) {
                    VStack(alignment: .leading) {
                        Text("Get fit")
                            .font(.largeTitle)
                        Text("with high intensity interval training")
                            .font(.headline)
                    }
                    Image("step-up")
                        .resizedToFill(width: 240, height: 240)
                }
                
               getStartedButton

            }
        }
    }
}


#Preview(traits: .sizeThatFitsLayout) {
    WelcomeView(selectedTab: .constant(9))
}


