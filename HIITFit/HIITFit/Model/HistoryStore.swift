//
//  HistoryStore.swift
//  HIITFit
//
//  Created by Arunkumar on 30/05/25.
//

import Foundation


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
}
