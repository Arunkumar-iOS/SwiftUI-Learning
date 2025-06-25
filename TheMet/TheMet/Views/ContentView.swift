//
//  ContentView.swift
//  TheMet
//
//  Created by Arunkumar on 23/06/25.
//

import SwiftUI

struct MetToolbarModifier: ViewModifier {
    @Binding var query: String
    @Binding var showQueryField: Bool
    @Binding var fetchObjectTask: Task<Void, Error>?
    
    @ObservedObject var store: TheMetStore

    func body(content: Content) -> some View {
        content
            .toolbar {
                Button("Search the Met") {
                    query = ""
                    showQueryField = true
                }
                .foregroundColor(Color.metBackground)
                .padding(.horizontal)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.metBackground, lineWidth: 2)
                )
            }
            .alert("Search the Met", isPresented: $showQueryField) {
              TextField("Search the Met", text: $query)
              Button("Search") {
                  fetchObjectTask?.cancel()
                  fetchObjectTask = Task {
                    do {
                        store.artObjects = []
                      try await store.fetchObjects(for: query)
                    } catch {}
                  }

                  
              }
            }

    }
}


extension View {
    func metToolbarModifier(
        query: Binding<String>,
        showQueryField: Binding<Bool>,
        store: TheMetStore,
        fetchObjectTask: Binding<Task<Void, Error>?>
    ) -> some View {
        modifier(
            MetToolbarModifier(
                query: query,
                showQueryField: showQueryField,
                fetchObjectTask: fetchObjectTask,
                store: store
            )
        )
    }
}

struct ContentView: View {
    
    @StateObject var theMetStore = TheMetStore()
    
    //To cancel the running task, use this.
    @State private var fetchObjectsTask: Task<Void, Error>?
    @State private var query = "rhino"
    @State private var showQueryField = false

    
    var body: some View {
        
        NavigationStack {
            
            VStack {
                
                Text("You searched for '\(query)'")
                  .padding(5)
                //Move a background before color, if you want to text tight around.
                  .background(Color.metForeground)
                  .cornerRadius(10)

                
                List(theMetStore.artObjects, id: \.objectID) { object in
                    
                    //If public domain is false, we should bring the user to safariView
                    if !object.isPublicDomain, let url = URL(string: object.objectURL) {
                        
                        NavigationLink(value: url) {
                            WebIndicatorView(title: object.title)
                        }
                        //Change the row color with the condition.
                        .listRowBackground(Color.metBackground)
                        .foregroundStyle(.white)
                        
                    } else {
                        
                        NavigationLink(value: object) {
                            Text(object.title)
                        }
                        .listRowBackground(Color.metForeground)
                    }
                    
                    /*
                     // Creates a tappable row labeled with object.title.
                     // On tap, pushes ObjectDetailView onto the navigation stack.
                     //Param titleKey and destination
                     NavigationLink(object.title) {
                     ObjectDetailView(object: object)
                     }
                     */
                    
                    
                    // Opens a URL in safari.
                    // Link(object.title, destination: URL(string: object.objectURL)!)
                    
                    
                    /*
                     //Open Safari inside app.
                     //param is destination and a label.
                     NavigationLink {
                     SafariView(url: URL(string: object.objectURL)!)
                     } label: {
                     WebIndicatorView(title: object.title)
                     }
                     */
                }
                
                .navigationTitle("The Met")
                //Extracted a toolbar as View Modifier.
                .metToolbarModifier(query: $query, showQueryField: $showQueryField, store: theMetStore, fetchObjectTask: $fetchObjectsTask)
                
                .navigationDestination(for: URL.self) { url in
                    SafariView(url: url)
                        .navigationBarTitleDisplayMode(.inline)
                        .ignoresSafeArea()
                }
                .navigationDestination(for: ArtObject.self) { object in
                    ObjectDetailView(object: object)
                }
            }
            
            .overlay {
              if theMetStore.artObjects.isEmpty { ProgressView() }
            }

        }
        //Work of task is to call an async function from main thread. Its like creating a bridge.
        .task {
            do {
                try await theMetStore.fetchObjects(for: query)
            } catch {
                print("Error loading art objects: \(error)")
            }
        }
    }
}

#Preview {
    ContentView()
}




