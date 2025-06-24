//
//  ObjectDetailView.swift
//  TheMet
//
//  Created by Arunkumar on 23/06/25.
//

import Foundation
import SwiftUI

struct WebViewStyle: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .multilineTextAlignment(.leading)
            .font(.callout)
            .frame(minWidth: 44)
    }
}

extension View {
    
    func webViewStyle() -> some View {
        modifier(WebViewStyle())
    }
}


struct ObjectDetailView: View  {
    
    var object: ArtObject
    
    var body: some View {
        VStack {
            if let url = URL(string: object.objectURL) {
                Link(destination: url) {
                    WebIndicatorView(title: object.title)
                        .webViewStyle()
                    // add these four modifiers
                        .padding()
                        .background(Color.metBackground)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            } else {
                Text(object.title)
                    .webViewStyle()
            }
            
            
            
            if object.isPublicDomain {
                AsyncImage(url: URL(string: object.primaryImageSmall)!) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                } placeholder: {
                    PlaceholderImageView(note: "Display Image here")
                }
                
            } else {
                PlaceholderImageView(note: "Image not in public domain. URL not valid.")
                
            }
            
            Text(object.creditLine)
                .webViewStyle()
                .padding()
                .background(Color.theMetForeground)
                .cornerRadius(10)
        }
        .padding(.vertical, 30)
    }
    
}


#Preview {
    ObjectDetailView(
    object:
        ArtObject(
        objectID: 452174,
        title: "Bahram Gur Slays the Rhino-Wolf",
        creditLine: "Gift of Arthur A. Houghton Jr., 1970",
        objectURL: "https://www.metmuseum.org/art/collection/search/452174",
        isPublicDomain: true,
        primaryImageSmall: "https://images.metmuseum.org/CRDImages/is/original/DP107178.jpg"))
}



struct PlaceholderImageView: View {
    
    var note: String
    
    var body: some View {
        ZStack {
            Rectangle()
                //.inset(by: 7)
                .fill(Color.blue)
                .border(Color.red, width: 7)
                .opacity(0.4)
                .padding()
            
            Text(note)
                .foregroundColor(.red)
        }
    }
}
