//
//  CustomTransfer.swift
//  Cards
//
//  Created by Arunkumar on 29/06/25.
//

import Foundation
import SwiftUI

// 1
struct CustomTransfer: Transferable {
    // 2
    var image: UIImage?
    var text: String?
    
    // 3
    public static var transferRepresentation:
    some TransferRepresentation {
        // 4
        DataRepresentation(importedContentType: .image) { data in
            let image = UIImage(data: data) ?? UIImage.error
            return CustomTransfer(image: image)
        }
        // 5
        DataRepresentation(importedContentType: .text) { data in
            let docType = NSAttributedString.DocumentType.html
            let encoding = String.Encoding.utf8.rawValue
            guard let text = try? NSAttributedString(
                data: data,
                options: [
                    .documentType: docType,
                    .characterEncoding: encoding
                ],
                documentAttributes: nil
            ) else {
                return CustomTransfer(text: nil)
            }
            return CustomTransfer(text: text.string)
        }
        
    }
}
