/// Copyright (c) 2025 Kodeco LLC
/// 
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
/// 
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
/// 
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
/// 
/// This project and source code may use libraries or frameworks that are
/// released under various Open-Source licenses. Use of those libraries and
/// frameworks are governed by their own individual licenses.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import Foundation
import SwiftUI


//iOS 17 and later observable pattern introduced as which observes the whole class and if get any changes in its properties it will automatically updates the view.
//By default every property is wrapped as @Published, so whoever subscribing this will get an automatic update.
//TheMetStore is a ViewModel
//If you're using Swift 5.9 / iOS 17+, the @Observable macro is from the Observation framework, and you can use regular stored properties (no @Published required):
// Class only supports the reference type property wrappers, which should be Observable and observableObject
@Observable class TheMetStore {

  var objects: [Object] = []
  //If you don't want view should track the property, you can declare it as private or @ObservationIgnored
  private let service = TheMetService()
  
  // also you avoid the observation like this
  @ObservationIgnored var maxIndex: Int
  
  init(_ maxIndex: Int = 20) {
    self.maxIndex = maxIndex
  }
  
  func fetchObjects(for queryTerm: String) async throws {
    if let objectIDs = try await service.getObjectIDs(from: queryTerm) {
      for (index, objectID) in objectIDs.objectIDs.enumerated()
      where index < maxIndex {
        if let object = try await service.getObject(from: objectID) {
          await MainActor.run {
            objects.append(object)
          }
        }
      }
    }
  }
}
