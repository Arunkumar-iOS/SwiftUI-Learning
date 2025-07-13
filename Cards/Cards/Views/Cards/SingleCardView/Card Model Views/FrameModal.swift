//
//  FrameModal.swift
//  Cards
//
//  Created by Arunkumar on 01/07/25.
//

import Foundation
import SwiftUI


struct FrameModal: View {
  @Environment(\.dismiss) var dismiss
  // 1
  @Binding var frameIndex: Int?
    
  private let columns = [
    GridItem(.adaptive(minimum: 120), spacing: 10)
  ]
  private let style = StrokeStyle(
    lineWidth: 5,
    lineJoin: .round)

  var body: some View {
    ScrollView {
      LazyVGrid(columns: columns) {
      // 2
        ForEach(0..<Shapes.shapes.count, id: \.self) { index in
          Shapes.shapes[index]
          // 3
            .stroke(Color.primary, style: style)
            // 4
           // Fill the shape so that you have a touch area. If you don’t fill the shape, the tap will only work on the stroke.
            .fill(Color.secondary)
            .frame(width: 100, height: 120)
            .padding()
            // 5
            .onTapGesture {
                //If the user selects frame update the index.
              frameIndex = index
              dismiss()
            }
        }
      }
    }
    .padding(5)
  }
}


#Preview(traits: .sizeThatFitsLayout) {
    FrameModal(frameIndex: .constant(nil))
}
