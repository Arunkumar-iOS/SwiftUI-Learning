//
//  Pet.swift
//  Paws
//
//  Created by Arunkumar on 28/06/25.
//

import Foundation
import SwiftData

@Model
//If you use final access control, this class won' be subclassed. so you can't override this.
final class Pet {
    
    var name: String
    //"SwiftData, please store this photo in an external file, and handle the storage location & cleanup automatically.
    @Attribute(.externalStorage) var photo: Data?
    
    init (name: String, photo: Data? = nil) {
        self.name = name
        self.photo = photo
    }
}



extension Pet {
    @MainActor
    static var previewDataContainer: ModelContainer {
     
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let modelContainer = try! ModelContainer(for: Pet.self, configurations: config)
        modelContainer.mainContext.insert(Pet(name: "Rexy"))
        modelContainer.mainContext.insert(Pet(name: "Bella"))
        modelContainer.mainContext.insert(Pet(name: "Charlie"))
        modelContainer.mainContext.insert(Pet(name: "Daisy"))
        modelContainer.mainContext.insert(Pet(name: "Fido"))
        modelContainer.mainContext.insert(Pet(name: "Gus"))
        modelContainer.mainContext.insert(Pet(name: "Mimi"))
        modelContainer.mainContext.insert(Pet(name: "Luna"))
        
        return modelContainer
        
    }
}
