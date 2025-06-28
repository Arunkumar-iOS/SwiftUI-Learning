//
//  ContentView.swift
//  WishList
//
//  Created by Arunkumar on 26/06/25.
//

import SwiftUI
import SwiftData


struct NavigationToolBarModifier: ViewModifier {
    
    @Binding var showAlert: Bool
    @Binding var wishesCount: Int
    
    func body(content: Content) -> some View {
        content
            .toolbar {
                //Top bar
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showAlert.toggle()
                    } label: {
                        Image(systemName: "plus")
                            .fontWeight(.bold)
                            .padding(.horizontal, 5)
                    }
                }
                
                //Bottom bar
                 ToolbarItem(placement: .bottomBar) {
                     Text("\(wishesCount) Wish\(wishesCount == 0 ? "" : "es")")
                }
            }
    }
}

extension View {
    func navigationToolBarModifier(showAlert: Binding<Bool>, wishesCount: Binding<Int>) -> some View {
        self
            .modifier(NavigationToolBarModifier(showAlert: showAlert, wishesCount: wishesCount))
    }
}


struct ContentView: View {
    
    // ModelContext is used to create a connection between view and container.So it can update, save and delete.
    @Environment(\.modelContext) var modelContext
    
    //This Macro will query the model from container. it observes the model whenever the changes there it will update immediately.
    @Query private var wishes: [Wish]
    
    @State private var showAlert: Bool = false
    @State private var wishName: String = ""
    @State private var wishesCount: Int = 0
    
    var body: some View {
        
        NavigationStack {
           
            List(wishes) { wish in
                Text(wish.title)
                    .font(.title2)
                    .fontWeight(.light)
                    .padding(.vertical, 5)
                //Gives swipe action to the list and will delete the record from container.
                    .swipeActions {
                        Button("Delete",role: .destructive) {
                            modelContext.delete(wish)
                        }
                    }
                
            }//: List
            .onAppear {
                wishesCount = wishes.count
            }
            .navigationTitle("Wishlist")
            .navigationToolBarModifier(showAlert: $showAlert, wishesCount: .constant(wishes.count))
            
            //Show alert
            .alert("Create a New Wish", isPresented: $showAlert) {
                TextField("Enter wish title", text: $wishName)

                Button("Save") {
                    modelContext.insert(Wish(title: wishName))
                    wishName = ""
                }
            }
            
            .overlay(
                wishes.isEmpty ?
                ContentUnavailableView("My WishList", systemImage: "heart.circle", description: Text("No wishes added yet. Add one to get started."))
                : nil
            )
            
            
            
        }
    }
    
}

//We can show the sample data to preview for testing purpose.
#Preview("List with Sample Data") {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Wish.self, configurations: config)
    
    container.mainContext.insert(Wish(title: "Sample Wish 1"))
    container.mainContext.insert(Wish(title: "Sample Wish 2"))
    container.mainContext.insert(Wish(title: "Sample Wish 3"))
    container.mainContext.insert(Wish(title: "Sample Wish 4"))
    container.mainContext.insert(Wish(title: "Sample Wish 5"))
    container.mainContext.insert(Wish(title: "Sample Wish 6"))

    return ContentView()
        .modelContainer(container)
}


#Preview("Empty List", body: {
    
    ContentView()
    //in memory means use memory for storing data for temporary database particularly for Preview.
        .modelContainer(for: [Wish.self], inMemory: true)
})
