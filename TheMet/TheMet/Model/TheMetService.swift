//
//  TheMetService.swift
//  TheMet
//
//  Created by Arunkumar on 25/06/25.
//

import Foundation


struct TheMetService {
  let baseURLString = "https://collectionapi.metmuseum.org/public/collection/v1/"
  let session = URLSession.shared
  let decoder = JSONDecoder()

  func getObjectIDs(from queryTerm: String) async throws -> ObjectIDs? {
    
      let objectIDs: ObjectIDs?  // 1

      guard
        var urlComponents = URLComponents(string: baseURLString + "search")
      else {  // 2
        return nil
      }
      let baseParams = ["hasImages": "true"]
      urlComponents.setQueryItems(with: baseParams)
      urlComponents.queryItems! += [URLQueryItem(name: "q", value: queryTerm)]
      guard let queryURL = urlComponents.url else { return nil }
      let request = URLRequest(url: queryURL)

      
      //After constructing URL, you may call the URL session request.
      let (data, response) = try await session.data(for: request)  // 1
      guard
        let response = response as? HTTPURLResponse,
        (200..<300).contains(response.statusCode)
      else {
        print(">>> getObjectIDs response outside bounds")
        return nil
      }

      do {  // 2
        objectIDs = try decoder.decode(ObjectIDs.self, from: data)
      } catch {
        print(error)
        return nil
      }
      return objectIDs  // 3

  }

  func getObject(from objectID: Int) async throws -> ArtObject? {
      let object: ArtObject?  // 1

      let objectURLString = baseURLString + "objects/\(objectID)"  // 2
      guard let objectURL = URL(string: objectURLString) else { return nil }
      let objectRequest = URLRequest(url: objectURL)

      let (data, response) = try await session.data(for: objectRequest)  // 3
      if let response = response as? HTTPURLResponse {
        let statusCode = response.statusCode
        if !(200..<300).contains(statusCode) {
          print(">>> getObject response \(statusCode) outside bounds")
          print(">>> \(objectURLString)")
          return nil
        }
      }

      do {  // 4
        object = try decoder.decode(ArtObject.self, from: data)
      } catch {
        print(error)
        return nil
      }
      return object  // 5

  }
}
