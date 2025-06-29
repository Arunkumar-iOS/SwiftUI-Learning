//
//  PetToolbar.swift
//  Paws
//
//  Created by Arunkumar on 29/06/25.
//

import SwiftUI

struct PetToolbar: ViewModifier {
    
    var onAddPet: () -> Void
    @Binding var isEditing: Bool
    
    func body(content: Content) -> some View {
        content
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        onAddPet()
                    } label: {
                        Image(systemName: "plus.circle")
                            .font(.title2)
                    }
                }
                
                ToolbarItem(placement: .topBarLeading) {
                    
                    
                    Button {
                        withAnimation {
                            isEditing.toggle()
                        }
                    } label: {
                        Image(systemName: "slider.horizontal.3")
                            .font(.title2)
                    }
                    
                }
                
                
            }
    }
    
    
}


extension View {
    func petToolbar(isEditing: Binding<Bool>, onAddPet: @escaping () -> Void) -> some View {
        modifier(PetToolbar(onAddPet: onAddPet, isEditing: isEditing))
    }
}


#Preview {
    NavigationStack {
        Text("Preview Toolbar")
            .petToolbar(isEditing: .constant(false)) {
                print("Tool bar tapped")
            }
    }
}

