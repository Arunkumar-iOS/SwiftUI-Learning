//
//  RaisedButton.swift
//  HIITFit
//
//  Created by Arunkumar on 10/06/25.
//

import Foundation
import SwiftUI


//Extension for text that use all the modifiers commonly.
extension Text {
    func raisedButtonTextStyle() -> some View {
    self
    .font(.body)
    .fontWeight(.bold)
    .foregroundColor(.primary)
  }
}


//Custom Button and add styles
struct RaisedButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
        //.background(Color.red)
            .padding([.top, .bottom], 12)
            .frame(maxWidth: .infinity)
            .background(
                Capsule()
                    .fill(Color.background)
                    .shadow(color: Color.dropShadow, radius: 4, x: 6, y: 6)
                    .shadow(color: Color.dropHighlight, radius: 4, x: -6, y: -6)
                
            )
    }
}

//The raised button style will be used only for RaisedButtonStyle not other styles.
extension ButtonStyle where Self == RaisedButtonStyle {
  static var raised: RaisedButtonStyle {
    .init()
  }
}


struct RaisedButton: View {
  let buttonText: String
  let action: () -> Void

  var body: some View {
    Button(action: {
      action()
    }, label: {
      Text(buttonText)
        .raisedButtonTextStyle()
    })
    .buttonStyle(.raised)
  }
}
