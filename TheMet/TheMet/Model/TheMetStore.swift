//
//  TheMetStore.swift
//  TheMet
//
//  Created by Arunkumar on 23/06/25.
//

import Foundation
import SwiftUI

//This store is a source of truth, that drives the app.
class TheMetStore: ObservableObject {
    @Published var artObjects: [ArtObject] = []
    
    let service = TheMetService()
    let maxIndex: Int

    init(_ maxIndex: Int = 30) {
      self.maxIndex = maxIndex
    }

    
    func fetchObjects(for queryTerm: String) async throws {
        
        if let objectIDs = try await service.getObjectIDs(from: queryTerm) {  // 1
          for (index, objectID) in objectIDs.objectIDs.enumerated()  // 2
            //Only call 30 objects.
          where index < maxIndex {
            if let object = try await service.getObject(from: objectID) {
                
                //Update the value in main thread.
                await MainActor.run {
                    self.artObjects.append(object)
                }
            }
          }
        }

    }
    
    //Use this for prototyping
    /*
    init() {
        #if DEBUG
        createDevData()
        #endif
    }
     */
}
