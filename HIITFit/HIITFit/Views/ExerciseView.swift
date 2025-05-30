//
//  ExerciseView.swift
//  HIITFit
//
//  Created by Arunkumar on 30/05/25.
//

import Foundation
import SwiftUI


struct ExerciseView: View {
    
    let index: Int
    
    let videoNames = ["squat", "step-up", "burpee", "sun-salute"]
    let exerciseNames = ["Squat", "Step Up", "Burpee", "Sun Salute"]

    
    var body: some View {
        Text("\(exerciseNames[index])")
    }
}
