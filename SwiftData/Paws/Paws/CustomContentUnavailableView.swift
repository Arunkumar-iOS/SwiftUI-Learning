//
//  CustomContentUnavailableView.swift
//  Paws
//
//  Created by Arunkumar on 28/06/25.
//

import SwiftUI


//This is how you can create a custom view.
struct CustomContentUnavailableView: View {
    //If you create a property like this, it is a stored property.
    // When you want to create a instance of this, swift will automatically gives you a default initializer by having that you can pass a value.
    var imageName: String
    var title: String
    var description: String
    
    
    var body: some View {
        
        ContentUnavailableView {
            Image(systemName: imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 80)
            
            Text(title)
                .font(.headline)
            
            Text(description)
                .font(.caption)
        }
        .foregroundStyle(.secondary)
    }
}

#Preview {
    CustomContentUnavailableView(
        imageName: "cat.circle",
        title: "No Photo",
        description: "Add a photo to continue."
    )
}
