//
//  HistoryStoreDevData.swift
//  HIITFit
//
//  Created by Arunkumar on 31/05/25.
//

import Foundation

//It's so handy, when you create a extension files we can move this to anywhere instead of scrolling through all the codes in the same file.
extension HistoryStore {
  mutating func createDevData() {
    // Development data
    exerciseDays = [
        //Here, this date you did a following exercises.
      ExerciseDay(
        date: Date().addingTimeInterval(-86400),
        exercises: [
          Exercise.exercises[0].exerciseName,
          Exercise.exercises[1].exerciseName,
          Exercise.exercises[2].exerciseName
        ]),
      ExerciseDay(
        date: Date().addingTimeInterval(-86400 * 2),
        exercises: [
          Exercise.exercises[1].exerciseName,
          Exercise.exercises[0].exerciseName
        ])
    ]
  }
}
