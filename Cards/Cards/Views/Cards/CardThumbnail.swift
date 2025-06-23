//
//  CardThumbnail.swift
//  Cards
//
//  Created by Arunkumar on 20/06/25.
//

import SwiftUI


struct CardThumbnail: View  {
    
    let card: Card
    
    var body: some View {
        RoundedRectangle(cornerRadius: 20)
            .foregroundStyle(card.backgroundColor)
            .frame(width: Settings.thumbnailSize.width,
                   height: Settings.thumbnailSize.height)
    }
}


#Preview {
    CardThumbnail(card: initialCards[0])
}
