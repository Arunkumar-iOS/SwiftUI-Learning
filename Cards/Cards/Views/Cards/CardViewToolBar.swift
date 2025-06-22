//
//  CardViewToolBar.swift
//  Cards
//
//  Created by Arunkumar on 22/06/25.
//

import Foundation
import SwiftUI


struct CardToolbar: ViewModifier {
    
    @Environment(\.dismiss) var dismiss
    
    @Binding var currentModal: ToolbarSelection?

    func body(content: Content) -> some View {
        content
        .toolbar {
            //Top Toolbar
            ToolbarItem(placement: .topBarTrailing) {
                Button("Done") {
                    dismiss()
                }
            }
            
            //Bottom Toolbar
            ToolbarItem(placement: .bottomBar) {
              BottomToolbar(modal: $currentModal)
            }

        }
    
        .sheet(item: $currentModal) { item in
          switch item {
          default:
            Text(String(describing: item))
          }
        }
    }
}


extension View {
    func cardToolbar(currentModal: Binding<ToolbarSelection?>) -> some View {
        self.modifier(CardToolbar(currentModal: currentModal))
    }
}

