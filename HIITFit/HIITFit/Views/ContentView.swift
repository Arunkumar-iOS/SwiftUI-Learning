//
//  ContentView.swift
//  HIITFit
//
//  Created by Arunkumar on 30/05/25.
//

import SwiftUI



struct ContentView: View {
    //Declaring this here means ContentView owns this.
    @SceneStorage("selectedTab") private var selectedTab = 9
    @StateObject private var historyStore = HistoryStore()
    
       

    var body: some View {
        TabView(selection: $selectedTab) {
            WelcomeView(selectedTab: $selectedTab)  // 1
                .tag(9)  // 2
            ForEach(Exercise.exercises.indices, id: \.self) { index in
                ExerciseView(selectedTab: $selectedTab, index: index)
                    .tag(index)  // 3
            }
        }
        .environmentObject(historyStore)
        
        /*
       //Show alert when you have no plist
        .alert(
          // 1
          "History",
          // 2
          isPresented: $historyStore.loadingError) {
            // 3
            Button("OK") { }
          } message: {
            // 4
            Text(
              """
              Unfortunately we can't load your past history.
              Email support:
              support@xyz.com
              """)
          }
         
        .tabViewStyle(.page)
        //This line used to show and hide the page dots(PageControl)
        .indexViewStyle(
            PageIndexViewStyle(backgroundDisplayMode: .never))
         */
        
    }
       
}

#Preview {
    ContentView()
}


