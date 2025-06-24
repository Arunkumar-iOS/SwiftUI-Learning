//
//  SafariView.swift
//  TheMet
//
//  Created by Arunkumar on 24/06/25.
//

import Foundation
import SwiftUI
import SafariServices

//UIViewControllerRepresentable is a protocol that takes two function.
struct SafariView: UIViewControllerRepresentable {
  let url: URL

  func makeUIViewController(
    context: UIViewControllerRepresentableContext<SafariView>
  ) -> SFSafariViewController {
    return SFSafariViewController(url: url)
  }

  func updateUIViewController(
    _ uiViewController: SFSafariViewController,
    context: UIViewControllerRepresentableContext<SafariView>) {}
}
