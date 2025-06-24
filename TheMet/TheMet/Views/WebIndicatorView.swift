//
//  WebIndicatorView.swift
//  TheMet
//
//  Created by Arunkumar on 24/06/25.
//
import SwiftUI

struct WebIndicatorView: View {
    
    var title: String
    
    var body: some View {
        HStack {
            Text(title)
            Spacer()
            Image(systemName: "rectangle.portrait.and.arrow.right.fill")
                .font(.footnote)
        }
    }
}


