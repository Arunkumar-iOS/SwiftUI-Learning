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
    
    let interval: TimeInterval = 30
    
    var exercise: Exercise {
      Exercise.exercises[index]
    }
   
    let index: Int
    
    var body: some View {
        //Using GeometryReader we can get the screen height and width.
        GeometryReader { geometry in
            VStack {
                HeaderView(exerciseName: exercise.exerciseName)
                    .padding(.bottom)
                VideoPlayerView(videoName: exercise.videoName)
                //We can get size like this.
                    .frame(height: geometry.size.height * 0.45)
                Text(Date().addingTimeInterval(interval), style: .timer)
                  .font(.system(size: geometry.size.height * 0.07))
                Button("Start/Done", action: {
                    print("Start button Tapped")
                })
                    .font(.title3)
                    .padding()
                RatingView()
                    .padding()
                Spacer()
                Button("History", action: {
                    print("History Button Tapped")
                })
                    .padding(.bottom)
            }
            
        }
       
       
    }
}


#Preview {
    ExerciseView(index: 0)
}


