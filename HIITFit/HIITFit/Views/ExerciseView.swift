//
//  ExerciseView.swift
//  HIITFit
//
//  Created by Arunkumar on 30/05/25.
//

import Foundation
import SwiftUI
import AVKit

struct ExerciseView: View {
    
    @EnvironmentObject var historyStore: HistoryStore
    
    //State Property
    @State private var showHistory: Bool = false
    @State private var showSuccess = false
    
    
    //Binding Property
    
    @Binding var selectedTab: Int
    
    //Check whether index reaches the last count. If it is last count it returns true.
    var lastExercise: Bool {
      index + 1 == Exercise.exercises.count
    }
    
    @State private var timerDone = false
    @State private var showTimer = false
    
    var exercise: Exercise {
      Exercise.exercises[index]
    }
    
    //Buttons
    var startButton: some View {
        RaisedButton(buttonText: "Start Exercise") {
            showTimer.toggle()
        }
    }
    
    var doneButton: some View {
        Button("Done", action: {
            print("Done Button tapped and code executed \(exercise.exerciseName)")
            timerDone = false
            showTimer.toggle()
            
            //Add exercise to history store.
            historyStore.addDoneExercise(exercise.exerciseName)

            if lastExercise {
               showSuccess.toggle()
             } else {
               selectedTab += 1
             }
            
           
        })
        .disabled(!timerDone)
        .sheet(isPresented: $showSuccess) {
            SuccessView( selectedTab: $selectedTab)
                .presentationDetents([.medium, .large])
        }
    }
    
    var historyButton: some View {
        Button("History", action: {
            showHistory.toggle()
        })
        .sheet(isPresented: $showHistory) {
            HistoryView(showHistory: $showHistory)
        }
    }
   
    let index: Int
    
    var body: some View {
        //Using GeometryReader we can get the screen height and width.
        GeometryReader { geometry in
            VStack {
                HeaderView(selectedTab: $selectedTab, titleText: exercise.exerciseName)
                    .padding(.bottom)
                VideoPlayerView(videoName: exercise.videoName)
                //We can get the size of frame like this.
                    .frame(height: geometry.size.height * 0.45)
               
                HStack(spacing: 150) {
                    Group {
                        startButton
                        doneButton
                    }
                    .font(.title3)
                    .padding()
                }
                //Show Timer
                 if showTimer {
                   TimerView(
                     timerDone: $timerDone,
                     size: geometry.size.height * 0.07
                   )
                 }
                Spacer()
                RatingView(exerciseIndex: index)
                    .padding()
                historyButton
                    .padding(.bottom)
            }
            
        }
       
       
    }
}


#Preview {
    ExerciseView(selectedTab: .constant(3), index: 3)
}

