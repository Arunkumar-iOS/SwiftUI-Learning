//
//  Exercise.swift
//  HIITFit
//
//  Created by Arunkumar on 30/05/25.
//

import Foundation


struct Exercise {
  
    var exerciseName: String
    var videoName: String
    
    enum ExerciseEnum: String {
        case squat = "Squat"
        case stepUp = "Step Up"
        case burpee = "Burpee"
        case sunSalute = "Sun Salute"
    }
    
    enum ExerciseVideoNameEnum: String {
        case squat = "squat"
        case stepUp = "step-up"
        case burpee = "burpee"
        case sunSalute = "sun-salute"
    }
}


extension Exercise {
    
    static let exercises: [Exercise] = [
        .init(exerciseName: ExerciseEnum.squat.rawValue, videoName: ExerciseVideoNameEnum.squat.rawValue),
        .init(exerciseName: ExerciseEnum.stepUp.rawValue, videoName: ExerciseVideoNameEnum.stepUp.rawValue),
        .init(exerciseName: ExerciseEnum.burpee.rawValue, videoName: ExerciseVideoNameEnum.burpee.rawValue),
        .init(exerciseName: ExerciseEnum.sunSalute.rawValue, videoName: ExerciseVideoNameEnum.sunSalute.rawValue)
    ]
}
