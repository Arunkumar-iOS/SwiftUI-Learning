//
//  CardThumbnail.swift
//  Cards
//
//  Created by Arunkumar on 20/06/25.
//

import SwiftUI


struct CardThumbnail: View  {
    
    var body: some View {
        RoundedRectangle(cornerRadius: 20)
            .foregroundStyle(.gray)
            .frame(width: 150, height: 250)
    }
}


#Preview {
    CardThumbnail()
}
