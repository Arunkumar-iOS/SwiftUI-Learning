//
//  TimerView.swift
//  HIITFit
//
//  Created by Arunkumar on 01/06/25.
//

import Foundation
import SwiftUI

struct CountdownView: View {
  let date: Date
  @Binding var timeRemaining: Int
  let size: Double

  var body: some View {
    Text("\(timeRemaining)")  // 5
      .font(.system(size: size, design: .rounded))
      .padding()
      .onChange(of: date) {  // 6
        timeRemaining -= 1
      }
  }
}

struct TimerView: View {
  @State private var timeRemaining: Int = 3  // 1
  @Binding var timerDone: Bool  // 2
  let size: Double

  var body: some View {
    TimelineView(  // 3
      .animation(
        minimumInterval: 1.0,
        paused: timeRemaining <= 0)) { context in
          CountdownView(  // 4
            date: context.date,
            timeRemaining: $timeRemaining,
            size: size)
        }
        .onChange(of: timeRemaining) {
          if timeRemaining < 1 {
            timerDone = true  // 7
          }
        }
  }
}

#Preview {
  TimerView(timerDone: .constant(false), size: 90)
}



/*
struct CountdownView: View {
  let date: Date
  @Binding var timeRemaining: Int
  let size: Double

  var body: some View {
    Text("\(timeRemaining)")  // 5
      .font(.system(size: size, design: .rounded))
      .padding()
      .onChange(of: date) {  // 6
        timeRemaining -= 1
      }
  }
}

struct TimerView: View {
  @State private var timeRemaining: Int = 3  // 1
  @Binding var timerDone: Bool  // 2
  let size: Double

  var body: some View {
    TimelineView(  // 3
      .animation(
        minimumInterval: 1.0,
        paused: timeRemaining <= 0)) { context in
          CountdownView(  // 4
            date: context.date,
            timeRemaining: $timeRemaining,
            size: size)
        }
        .onChange(of: timeRemaining) {
          if timeRemaining < 1 {
            timerDone = true  // 7
          }
        }
  }
}

#Preview {
  TimerView(timerDone: .constant(false), size: 90)
}
*/
