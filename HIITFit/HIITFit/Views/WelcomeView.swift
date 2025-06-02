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
    @Binding var historyStore: HistoryStore
    
    
    var body: some View {
        ZStack {
            VStack {
                HeaderView(selectedTab: $selectedTab, titleText: "Welcome")
                    .padding(.bottom)
                Spacer()
                Button("History", action: {
                    showHistory.toggle()
                })
                .sheet(isPresented: $showHistory) {
                    HistoryView(historyStore: $historyStore, showHistory: $showHistory)
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
                
                Button(action: {
                    selectedTab = 0
                }) {
                    HStack {
                        Text("Get Started")
                        Image(systemName: "arrow.right.circle")
                    }
                    .padding()
                    .font(.title2)
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.gray, lineWidth: 2))
                }
                .padding(.top)
            }
            
            
            
            
        }
    }
}


#Preview(traits: .sizeThatFitsLayout) {
    WelcomeView(selectedTab: .constant(9), historyStore: .constant(HistoryStore()))
}
