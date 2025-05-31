//
//  HistoryView.swift
//  HIITFit
//
//  Created by Arunkumar on 30/05/25.
//

import Foundation
import SwiftUI


struct HistoryView: View {
    
    let today = Date()
    let yesterday = Date().addingTimeInterval(-86400)
    
    let exercises1 = ["Squat", "Step Up", "Burpee", "Sun Salute"]
    let exercises2 = ["Squat", "Step Up", "Burpee"]
    
    
    var body: some View {
        VStack {
            Text("History")
                .font(.title)
            //Default padding is 16. If you want custom padding you can set
                .padding()
        }
        
        //Form is a container view usually it used to show the arranged views.
        Form {
            
            Section(
                header:
                    Text(today.formatted(as: "MMM d"))
                    .font(.headline)) {
                        ForEach(exercises1, id: \.self) { exercise in
                            Text(exercise)
                                .font(.footnote)
                                .foregroundStyle(.gray)
                        }
                    }
            Section(
                header:
                    Text(yesterday.formatted(as: "MMM d"))
                    .font(.headline)) {
                        ForEach(exercises2, id: \.self) { exercise in
                            Text(exercise)
                                .font(.footnote)
                                .foregroundStyle(.gray)
                        }
                    }
        }
        
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    HistoryView()
}
