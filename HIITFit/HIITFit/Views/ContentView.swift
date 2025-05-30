//
//  ContentView.swift
//  HIITFit
//
//  Created by Arunkumar on 30/05/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView() {
            WelcomeView()
            
            ForEach(Exercise.exercises.indices, id: \.self) { index in
                ExerciseView(index: index)
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
