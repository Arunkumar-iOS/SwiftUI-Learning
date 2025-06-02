//
//  HistoryView.swift
//  HIITFit
//
//  Created by Arunkumar on 30/05/25.
//

import Foundation
import SwiftUI


struct HistoryView: View {
    
    let history = HistoryStore()
    @Binding var showHistory: Bool
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            
           VStack {
                Text("History")
                    .font(.title)
                //Default padding is 16. If you want custom padding you can set
                    .padding()
                
                //Form is a container view usually it used to show the arranged views.
                Form {
                    ForEach(history.exerciseDays) { day in
                        Section(
                            header:
                                Text(day.date.formatted(as: "MMM d"))
                                .font(.headline)) {
                                    //Inside the section
                                    //Again looping to get the exercise name.
                                    ForEach(day.exercises, id: \.self) { exercise in
                                        Text(exercise)
                                    }
                                }
                    }
                }
            }
            //In Zstack last view you declare will be top of the all views
            Button(action: {
                showHistory.toggle()
            }) {
                Image(systemName: "xmark.circle")
                    .padding()
                    .font(.title)
                    
            }
            
            
           
        }
        
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    HistoryView(showHistory: .constant(true))
}
