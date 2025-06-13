//
//  RatingView.swift
//  HIITFit
//
//  Created by Arunkumar on 30/05/25.
//

import Foundation
import SwiftUI


struct RatingView: View {
    
    let exerciseIndex: Int
    
    // UserDefaults bridge
    @AppStorage("ratings") private var ratings = "0000"
    @State private var rating = 0

    
    let maximumRating = 5
    
    var onColor: Color = .red
    var offColor: Color = .gray
    
    
    // 1
    init(exerciseIndex: Int) {
      self.exerciseIndex = exerciseIndex
      // 2
      let desiredLength = Exercise.exercises.count
      if ratings.count < desiredLength {
        // 3
        ratings = ratings.padding(
          toLength: desiredLength,
          withPad: "0",
          startingAt: 0)
      }
    }

    
    
    fileprivate func convertRating() {
        let index = ratings.index(ratings.startIndex, offsetBy: self.exerciseIndex)
        let character = ratings[index]
        rating = character.wholeNumberValue ?? 0
    }
    
    var body: some View {
        HStack {
            
            ForEach(1..<maximumRating + 1, id: \.self) { index in
                Image(systemName: "waveform.path.ecg")
                    .font(.largeTitle)
                    .foregroundColor(index <= rating ? onColor : offColor)
                    .onTapGesture {
                        updateRating(index: index)
                    }
                    .onAppear() {
                        convertRating()
                    }
            }
        }
        
    }
    
    func updateRating(index: Int) {
      rating = index
      let index = ratings.index(
        ratings.startIndex,
        offsetBy: exerciseIndex)
      ratings.replaceSubrange(index...index, with: String(rating))
    }

}

//Used to show only a particular view. Instead of loading all elements in view.
#Preview(traits: .sizeThatFitsLayout) {
  RatingView(exerciseIndex: 0)
}

