//
//  ContentView.swift
//  HIITFit
//
//  Created by Arunkumar on 30/05/25.
//

import SwiftUI

struct ContentView: View {
    //Declaring this here means ContentView owns this.
    @State private var selectedTab = 9
    @State private var historyStore = HistoryStore()

    var body: some View {
        TabView(selection: $selectedTab) {
            WelcomeView(selectedTab: $selectedTab, historyStore: $historyStore)  // 1
                .tag(9)  // 2
            ForEach(Exercise.exercises.indices, id: \.self) { index in
                ExerciseView(historyStore: $historyStore, selectedTab: $selectedTab, index: index)
                    .tag(index)  // 3
            }
        }
        
        .tabViewStyle(.page)
        //This line used to show and hide the page dots(PageControl)
        .indexViewStyle(
            PageIndexViewStyle(backgroundDisplayMode: .never))
        
    }
}


#Preview {
    ContentView()
}
