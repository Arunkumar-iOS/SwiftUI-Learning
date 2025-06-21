//
//  SingleCardView.swift
//  Cards
//
//  Created by Arunkumar on 20/06/25.
//

import Foundation
import SwiftUI


struct SingleCardView: View  {
    
    @Environment(\.dismiss) var dismiss
    
    @State private var currentModal: ToolbarSelection?
    
    var body: some View {
        NavigationStack {
            Color.yellow
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
    
}


#Preview {
    SingleCardView()
}
