//
//  ToolbarSelection.swift
//  Cards
//
//  Created by Arunkumar on 20/06/25.
//

import Foundation
import SwiftUI

enum ToolbarSelection: CaseIterable, Identifiable {
    
    //Hashvalue gives a unquie value of each and every case. why we are using this because stored property will not supported by enum.
    var id: Int {
      hashValue
    }

  case photoModal, frameModal, stickerModal, textModal
}
