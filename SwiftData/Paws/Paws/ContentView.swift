//
//  ContentView.swift
//  Paws
//
//  Created by Arunkumar on 28/06/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    
    @Environment(\.modelContext) var modelContext
    // Create a query to fetch value from database
    @Query private var pets: [Pet]
    
    //It's like a programmatic navigation, there won't be any user interaction needed for navigating the user.
    // This array maintains the list of screen with the help of that we can push or pop.
    @State private var path: [Pet] = []
    
    @State private var isEditingTapped: Bool = false
    
    
    let layout = [
        GridItem(.flexible(minimum: 120)),
        GridItem(.flexible(minimum: 120))
    ]
    
    func addPet() {
        let newPet = Pet(name: "New Pet", photo: nil)
        modelContext.insert(newPet)
        
        isEditingTapped = false
        path = [newPet]
    }
    
    var body: some View {
        //If you created a nav stack whatever you laying out must be inside of stack only, because it acts as a root view.
        NavigationStack(path: $path) {
            ScrollView {
                LazyVGrid(columns: layout) {
                    ForEach(pets) { pet in
                        NavigationLink(value: pet) {
                            
                            VStack {
                                if let imageData = pet.photo, let image = UIImage(data: imageData) {
                                    Image(uiImage: image)
                                        .resizable()
                                        .scaledToFit()
                                        .clipShape(RoundedRectangle(cornerRadius: 8, style: .circular))
                                       // .clipShape(RoundedRectangle(cornerSize: 12, style: .circular))
                                } else {
                                    Image(systemName: "pawprint.circle")
                                        .resizable()
                                        .scaledToFit()
                                        .padding(40)
                                        .foregroundStyle(.quaternary)
                                }
                                
                                Spacer()
                                Text(pet.name)
                                    .font(.title.weight(.light))
                                    .padding(.vertical)
                                Spacer()
                            } //: - VSTACK
                            .overlay(alignment: .topTrailing) {
                                
                                if isEditingTapped {
                                    //Menu is like a action tool bar.
                                    // shows a list of action will be used.
                                    Menu {
                                       Button(action: {
                                            modelContext.delete(pet)
                                         try? modelContext.save()
                                        }) {
                                            Text("Delete")
                                            Image(systemName: "trash")
                                        }
                                    } label: {
                                        Image(systemName: "trash.circle.fill")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 36, height: 36)
                                            .foregroundStyle(.red)
                                            .padding(8)
                                    }
                                }
                                
                            }
                            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                            .background(.ultraThinMaterial)
                            .clipShape(RoundedRectangle(cornerRadius: 8, style: .circular))
                            
                        }
                    } //: For Each
                }//: Grid
                .padding(.horizontal)
            } //: SCROLL VIEW
            //Here, we should tell the view where you want  to go.
            .navigationDestination(for: Pet.self) { pet in
                EditPetView(pet: pet)
            }
            .navigationTitle(pets.isEmpty ? "" : "Paws")
            
//MARK: - To do Toolbar
            .petToolbar(isEditing: $isEditingTapped) {
                addPet()
            }
            
            .overlay {
                if pets.isEmpty {
                    CustomContentUnavailableView(imageName: "dog.circle", title: "No Photos", description: "Add a photo to get started.")
                }
            }
            
        }//: NAVSTACK
    }
}

#Preview("Sample Data") {
    
    ContentView()
        .modelContainer(Pet.previewDataContainer)
    
}

#Preview("No Data") {
    ContentView()
        .modelContainer(for: Pet.self, inMemory: true)
}
