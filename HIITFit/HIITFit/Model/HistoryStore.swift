//
//  HistoryStore.swift
//  HIITFit
//
//  Created by Arunkumar on 30/05/25.
//

import Foundation
import SwiftUI

struct ExerciseDay: Identifiable {
    let id = UUID()
    let date: Date
    var exercises: [String] = []
}

struct HistoryStore {
    init() {
#if DEBUG
        createDevData()
#endif
    }
    var exerciseDays: [ExerciseDay] = []
    
    mutating func addDoneExercise(_ exerciseName: String) {
        let today = Date()
        if today.isSameDay(as: exerciseDays[0].date) { // 1
            print("Adding \(exerciseName)")
            exerciseDays[0].exercises.append(exerciseName)
        } else {
            exerciseDays.insert( // 2
                ExerciseDay(date: today, exercises: [exerciseName]),
                at: 0)
        }
    }
}
