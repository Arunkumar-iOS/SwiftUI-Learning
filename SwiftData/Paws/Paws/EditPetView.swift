//
//  EditPetView.swift
//  Paws
//
//  Created by Arunkumar on 29/06/25.
//

import SwiftUI
import SwiftData
//If you want to access the device photo library, we should use this framework.
import PhotosUI

struct EditPetView: View {
    
    @Environment(\.modelContext) var modelContext
    
    @Environment(\.dismiss) var dismiss
    
    @Bindable var pet: Pet
    
    @State private var photosPickerItem: PhotosPickerItem?
    
    var body: some View {
        Form {
            // MARK: - IMAGE
            if let imageData = pet.photo,
               let image = UIImage(data: imageData) {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .clipShape(RoundedRectangle(cornerRadius: 15), style: .init())
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 300)
                    .padding(.top)
            } else {
                CustomContentUnavailableView(
                    imageName: "pawprint.circle",
                    title: "No Photo",
                    description: "Add a photo of your favourite pet to make it easier to find them.")
                .padding()
            }
            
            // MARK: - PHOTO PICKER
            PhotosPicker(
                selection: $photosPickerItem,
                matching: .images,
                photoLibrary: .shared()
            ) {
                Label("Select a Photo", systemImage: "photo.badge.plus")
                    .frame(minWidth: 0, maxWidth: .infinity)
                    
            }

            .listRowSeparator(.hidden)

            //MARK: - TEXT FIELD
            TextField("Name", text: $pet.name)
                .textFieldStyle(.roundedBorder)
                .font(.largeTitle.weight(.light))
                .padding(.vertical)
            //MARK: - BUTTON
            Button {
                //Save into model container
                modelContext.insert(Pet(name: pet.name, photo: pet.photo))
                dismiss()
                
            } label: {
                Text("Save")
                    .font(.title2.weight(.light))
                    .frame(maxWidth: .infinity)
                    .padding(8)
            }
            .buttonStyle(.borderedProminent)
            .listRowSeparator(.hidden)
            
        }//: FORM
        .formStyle(.automatic)
        .navigationTitle("Edit \(pet.name)")
        // This modifier gets a photo data from the Gallery as Data, so we can show it to user.
        .onChange(of: photosPickerItem) {
            Task {
                if let loadedData = try? await photosPickerItem?.loadTransferable(type: Data.self) {
                    pet.photo = loadedData
                } else {
                    print("Failed")
                }
            }
        }
    }
}

#Preview {
    let container = try! ModelContainer(for: Pet.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
    
    EditPetView(pet: Pet(name: "Rio"))
        .modelContainer(container)
}
