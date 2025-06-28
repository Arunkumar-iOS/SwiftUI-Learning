//
//  Wish.swift
//  WishList
//
//  Created by Arunkumar on 27/06/25.
//

import Foundation
import SwiftData


//If you use a model for core data you must use @Model macro and class object.
@Model//Actually this model macro converts the model into swiftModel, so it will adapt the following (Identifiable, Hashable, iteratable) behind the scene.
class Wish {
    
    var title: String
    
    init(title: String) {
        self.title = title
    }
    
}
