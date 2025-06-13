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
        VStack(spacing: 0) {
            HeaderView(
                selectedTab: $selectedTab,
                titleText: "Welcome")
          //  Spacer()
            // container view
            ContainerView {
                ViewThatFits {
                  VStack {
                    WelcomeView.images
                    WelcomeView.welcomeText
                    getStartedButton
                    Spacer()
                    historyButton
                  }
                  VStack {
                    WelcomeView.welcomeText
                    getStartedButton
                    Spacer()
                    historyButton
                  }
                }
            }
            
        }
        .background(GradientBackground())
        .sheet(isPresented: $showHistory) {
            HistoryView(showHistory: $showHistory)
        }
    }

}


#Preview(traits: .sizeThatFitsLayout) {
    WelcomeView(selectedTab: .constant(9))
}


