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
            .foregroundStyle(Color.random())
            .frame(width: Settings.thumbnailSize.width,
                   height: Settings.thumbnailSize.height)
    }
}


#Preview {
    CardThumbnail()
}
