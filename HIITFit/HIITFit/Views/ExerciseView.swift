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
   
    let index: Int
    
    var body: some View {
        //Using GeometryReader we can get the screen height and width.
        GeometryReader { geometry in
            VStack {
              HeaderView(
                selectedTab: $selectedTab,
                titleText: Exercise.exercises[index].exerciseName)
                // It gives full width of the screen.
             // .frame(height: geometry.size.height * 0.2)
                // It gives a container frame size like where it proposed.
              .containerRelativeFrame(.vertical) { length, _ in
                length * 0.2
              }
              ContainerView {
                VStack {
                  VideoPlayerView(videoName: exercise.videoName)
                    .frame(height: geometry.size.height * 0.35)
                    .padding()
                  HStack(spacing: 150) {
                    startButton
                    doneButton
                      .disabled(!timerDone)
                      .sheet(isPresented: $showSuccess) {
                        SuccessView(selectedTab: $selectedTab)
                          .presentationDetents([.medium, .large])
                      }
                  }
                  .font(.title3)
                  .padding()

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
                    .sheet(isPresented: $showHistory) {
                      HistoryView(showHistory: $showHistory)
                    }
                    .padding(.bottom)
                }
              }
              .containerRelativeFrame(.vertical) { length, _ in
                length * 0.8
              }
            }
            
        }
        .background(GradientBackground())
    }
}


#Preview {
    ExerciseView(selectedTab: .constant(3), index: 3)
}

