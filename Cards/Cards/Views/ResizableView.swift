//
//  ResizeableView.swift
//  Cards
//
//  Created by Arunkumar on 21/06/25.
//

import Foundation
import SwiftUI


struct ResizableView: ViewModifier {
    
    @Binding var transform: Transform
    
    @State private var previousOffset: CGSize = .zero
    @State private var previousRotation: Angle = .zero
    @State private var scale: CGFloat = 1.0

    
    //Computed Property
    var dragGesture: some Gesture {
      DragGesture()
        .onChanged { value in
          transform.offset = value.translation + previousOffset
        }
        .onEnded { _ in
          previousOffset = transform.offset
        }
    }
    
    var rotationGesture: some Gesture {
      RotationGesture()
        .onChanged { rotation in
          transform.rotation = previousRotation + rotation
          previousRotation = rotation
        }
        .onEnded { _ in
          previousRotation = .zero
        }
    }
    
    var scaleGesture: some Gesture {
      MagnificationGesture()
        .onChanged { scale in
          self.scale = scale
        }
        .onEnded { scale in
          transform.size.width *= scale
          transform.size.height *= scale
          self.scale = 1.0
        }
    }

    func body(content: Content) -> some View {
        
        content
            .frame(width: transform.size.width, height: transform.size.height)
        
            .onAppear {
              previousOffset = transform.offset
            }

           
        //All dimensions are coming from model.
        //Position here matters check properly
            .gesture(SimultaneousGesture(rotationGesture, scaleGesture))
            .offset(transform.offset)
            .gesture(dragGesture)
            .gesture(rotationGesture)

    }
}


#Preview {
  @Previewable @State var transform = Transform()
  RoundedRectangle(cornerRadius: 30)
    .foregroundStyle(.blue)
    .resizableView(transform: $transform)
}




//MARK:- Extension View
extension View {
    func resizableView(transform: Binding<Transform>) -> some View {
        modifier(ResizableView(transform: transform))
    }
    
}

