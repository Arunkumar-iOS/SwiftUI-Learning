/// Copyright (c) 2024 Kodeco LLC
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

import SwiftUI

struct ContentView: View {
  //To make read and write the store, you can make this as bindable.
  //Now you are using @State property so passing value is mandatory to its subviews
  
  //@Bindable var store: TheMetStore
  
  //If you use environment property you can do bindable like
  @Environment(TheMetStore.self) var store: TheMetStore
  
  @State private var query = "rhino"
  @State private var showQueryField = false
  @State private var fetchObjectsTask: Task<Void, Error>?

  var body: some View {
    NavigationStack {
      VStack {
        
        
        
        Text("You searched for \(store.maxIndex) '\(query)' objects")
          .padding(5)
          .background(Color.metForeground)
          .cornerRadius(10)
        //here you are overriding the objects, so you mentioned this as $ also the store objects is bindable.
        /*
        List($store.objects) { $object in
          if !object.isPublicDomain,
            let url = URL(string: object.objectURL) {
            NavigationLink(value: url) {
              WebIndicatorView(title: object.title)
            }
            .listRowBackground(Color.metBackground)
            .foregroundColor(.white)
          } else {
            NavigationLink(object.title) {
              ObjectView(object: $object)
            }
            .listRowBackground(Color.metForeground)
          }
        }
         */
         
        //Above is an example for @State property binding
        
        
        //If you environment property to make binding
        
        @Bindable var twoWayStore = store
        
         List($twoWayStore.objects) { $object in
           if !object.isPublicDomain,
             let url = URL(string: object.objectURL) {
             NavigationLink(value: url) {
               WebIndicatorView(title: object.title)
             }
             .listRowBackground(Color.metBackground)
             .foregroundColor(.white)
           } else {
             NavigationLink(object.title) {
               ObjectView(object: $object)
             }
             .listRowBackground(Color.metForeground)
           }
         }
        
        
        .navigationTitle("The Met")
        .toolbar {
          Button("Search the Met") {
            query = ""
            showQueryField = true
          }
          .foregroundColor(Color.metBackground)
          .padding(.horizontal)
          .background(
            RoundedRectangle(cornerRadius: 8)
              .stroke(Color.metBackground, lineWidth: 2))
        }
        .alert(
          "Search the Met",
          isPresented: $showQueryField,
          actions: {
            TextField("Search the Met", text: $query)
            Button("Search") {
              fetchObjectsTask?.cancel()
              fetchObjectsTask = Task {
                do {
                  store.objects = []
                  try await store.fetchObjects(for: query)
                } catch {}
              }
            }
          })
        .navigationDestination(for: URL.self) { url in
          SafariView(url: url)
            .navigationBarTitleDisplayMode(.inline)
            .ignoresSafeArea()
        }
      }
      .overlay {
        if store.objects.isEmpty { ProgressView() }
      }
    }
    .task {
      do {
        try await store.fetchObjects(for: query)
      } catch {}
    }
  }
}

#Preview {
  
  ContentView()
    .environment(TheMetStore())
  
  //Uncomment it if you are using for @State property
  //ContentView(store: TheMetStore())
}
