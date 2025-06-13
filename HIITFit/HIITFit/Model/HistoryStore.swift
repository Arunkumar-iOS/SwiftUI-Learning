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

class HistoryStore: ObservableObject {
    
    //While save and load, if you encounter any problem show that to the users.
    enum FileError: Error {
        case loadError
        case saveError
    }
    
    @Published var loadingError: Bool = false
    
    var exerciseDays: [ExerciseDay] = []
    
    var dataURL: URL {
        URL.documentsDirectory
            .appendingPathComponent("history.plist")
    }
    
    
    init() {
        print("Initialising HistoryStore\n")
        loadingError = true
#if DEBUG
        // createDevData()
#endif
        do {
            try load()
        } catch {
            print("History Store = \(loadingError)")
            print("Error:", error)
        }
        
    }
    
    
    func addDoneExercise(_ exerciseName: String) {
        let today = Date()
        
        //You can stackup multiple condition to safely unwrap a value.
        if let firstDate = exerciseDays.first?.date, today.isSameDay(as: firstDate) { // 1
            print("Adding \(exerciseName)")
            exerciseDays[0].exercises.append(exerciseName)
        } else {
            exerciseDays.insert( // 2
                ExerciseDay(date: today, exercises: [exerciseName]),
                at: 0)
        }
        
        print("History: ", exerciseDays)
        
        do {
            try save()
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func load() throws {
        
        guard let data = try? Data(contentsOf: dataURL) else {
          return
        }
        
        do {
            // 2
            let plistData = try PropertyListSerialization.propertyList(
                from: data,
                options: [],
                format: nil)
            // 3
            let convertedPlistData = plistData as? [[Any]] ?? []
            // 4
            exerciseDays = convertedPlistData.map {
            
                ExerciseDay(
                    date: $0[1] as? Date ?? Date(),
                    exercises: $0[2] as? [String] ?? [])
            }
        } catch {
            throw FileError.loadError
        }
    }
    
    
    //Create an array that holds exercises.
    func save() throws {
        let plistData: [[Any]] = exerciseDays.map {
            //returns a new array after transforming the old array
            [$0.id.uuidString, $0.date, $0.exercises]
        }
        
        do {
            // 1
            let data = try PropertyListSerialization.data(
                fromPropertyList: plistData,
                format: .binary,
                options: .zero)
            // 2
            try data.write(to: dataURL, options: .atomic)
        } catch {
            // 3
            throw FileError.saveError
        }
        
    }
    
}
