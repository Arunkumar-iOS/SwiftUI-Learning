//
//  StickerModel.swift
//  Cards
//
//  Created by Arunkumar on 29/06/25.
//

import SwiftUI

struct StickerModal: View {
   
    @State private var stickerNames: [String] = []
    @Binding var stickerImage: UIImage?
    
    @Environment(\.dismiss) var dismiss

    //In VGrid you defines the column, here there will be a 3 column in a row.
    let columns = [
      GridItem(.adaptive(minimum: 120), spacing: 10)
    ]


    
    var body: some View {
      ScrollView {
         // It lazily creates views only when they are needed
          //VStack will create all 1,000 views immediately → memory heavy.
          //LazyVStack will only create the ones that are currently on screen → fast & smooth scrolling.
          LazyVGrid(columns: columns) {
              ForEach(stickerNames, id: \.self) { sticker in
                  Image(uiImage: image(from: sticker))
                      .resizable()
                      .aspectRatio(contentMode: .fit)
                      .onTapGesture {
                        stickerImage = image(from: sticker)
                        dismiss()
                      }
              }
          }
      }
      .onAppear {
        stickerNames = Self.loadStickers()
      }
      

    }

    
    static func loadStickers() -> [String] {
      var themes: [URL] = []
      var stickerNames: [String] = []
        
        // 1
        let fileManager = FileManager.default
        if let resourcePath = Bundle.main.resourcePath,
          // 2
          let enumerator = fileManager.enumerator(
            at: URL(fileURLWithPath: resourcePath + "/Stickers"),
            includingPropertiesForKeys: nil,
            options: [
              .skipsSubdirectoryDescendants,
              .skipsHiddenFiles
            ]) {
              // 3
            //First line of below says:
            //"Go through each item in enumerator."
              for case let url as URL in enumerator
              where url.hasDirectoryPath {
                themes.append(url)
              }
        }
        
        for theme in themes {
          if let files = try?
          fileManager.contentsOfDirectory(atPath: theme.path) {
            for file in files {
              stickerNames.append(theme.path + "/" + file)
            }
          }
        }
        return stickerNames


    }
    
    func image(from path: String) -> UIImage {
        print(
         "loading:",
         NSString(string: path).lastPathComponent)
      return UIImage(named: path) ?? UIImage.error
    }



}

#Preview {
    StickerModal(stickerImage: .constant(UIImage()))
}
