//
//  BubbleView.swift
//  Hike
//
//  Created by Arunkumar on 25/06/25.
//

import Foundation
import SwiftUI


struct Bubble: Identifiable {
    let id = UUID()
    var x: CGFloat
    var y: CGFloat
    var size: CGFloat
    var speed: Double
    var scale: CGFloat
}


class BubbleStore: ObservableObject {
    @Published var bubbles: [Bubble] = []

    init(count: Int) {
        for _ in 0..<count {
            let bubble = Bubble(
                x: CGFloat.random(in: 0...256),
                y: CGFloat.random(in: 0...256),
                size: CGFloat.random(in: 4...80),
                speed: Double.random(in: 0.05...2.0),
                scale: CGFloat.random(in: 0.1...2)
            )
            bubbles.append(bubble)
        }
    }
}

struct BubbleView: View {
    @StateObject var store = BubbleStore(count: 20)
    @State private var animate = false

    var body: some View {
        ZStack {
            ForEach(store.bubbles) { bubble in
                Circle()
                    .fill(.white).opacity(0.3)
                    .frame(width: bubble.size, height: bubble.size)
                    .position(x: bubble.x, y: bubble.y)
                    .scaleEffect( animate ? bubble.scale : 1)
                    
                    .onAppear {
                        withAnimation(.interpolatingSpring(stiffness: 0.25, damping: 0.25).repeatForever()
                            .speed(bubble.speed)) {
                                animate = true
                            }
                    }
            }
        }
        .frame(width: 256, height: 256)
        .mask(Circle())
        .drawingGroup()
    }
}


#Preview {
    BubbleView(store: BubbleStore(count: 20))
        .background(Color.black.opacity(0.9))
}
