//
//  CardsListView.swift
//  Cards
//
//  Created by Arunkumar on 20/06/25.
//

import Foundation
import SwiftUI


struct CardsListView: View  {
    
    @State private var isPresented = false
    
    var body: some View {
        
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                ForEach(0..<10) { _ in
                    CardThumbnail()
                        .onTapGesture {
                            isPresented = true
                        }
                }
            }
        }
        //To show a full screen model.
        .fullScreenCover(isPresented: $isPresented) {
            SingleCardView()
        }
    }
}


#Preview {
    CardsListView()
}
