//
//  VideoPlayerView.swift
//  HIITFit
//
//  Created by Arunkumar on 30/05/25.
//

import Foundation
import SwiftUI
import AVKit

struct VideoPlayerView: View {
    
    let videoName: String
    
    var videoURL: URL {
        
        Bundle.main.url(forResource: videoName, withExtension: "mp4")!
    }
    
    var body: some View {
        
        VideoPlayer(player: AVPlayer(url: videoURL))
    }
}
