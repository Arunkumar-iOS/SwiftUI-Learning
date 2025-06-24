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
              Button("Search") { }
            }

    }
}


extension View {
    func metToolbarModifier(query: Binding<String>, showQueryField: Binding<Bool>) -> some View {
        modifier(MetToolbarModifier(query: query, showQueryField: showQueryField))
    }
}

struct ContentView: View {
    
    @StateObject var theMetStore = TheMetStore()
    
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
                .metToolbarModifier(query: $query, showQueryField: $showQueryField)
                
                .navigationDestination(for: URL.self) { url in
                    SafariView(url: url)
                        .navigationBarTitleDisplayMode(.inline)
                        .ignoresSafeArea()
                }
                .navigationDestination(for: ArtObject.self) { object in
                    ObjectDetailView(object: object)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}




