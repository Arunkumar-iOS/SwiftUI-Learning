//
//  CustomHikingButtonView.swift
//  Hike
//
//  Created by Arunkumar on 25/06/25.
//

import SwiftUI


struct AboutApp: Hashable {
    var rowIcon: String
    var rowLabel: String
    var rowContent: String
    var rowTintColor: Color
    var rowLink: String?
    var rowLinkDestination: URL?
}

struct AboutAppStore {
    
    static func getAboutAppStore() -> [AboutApp] {
        var aboutApp: [AboutApp] = []

        aboutApp.append(AboutApp(rowIcon: "apps.iphone", rowLabel: "Application", rowContent: "HIKE", rowTintColor: .blue))
        
        aboutApp.append(AboutApp(rowIcon: "info.circle", rowLabel: "Compatibility", rowContent: "iOS, iPadOS", rowTintColor: .red))
        
        aboutApp.append(AboutApp(rowIcon: "swift", rowLabel: "Technology", rowContent: "Swift", rowTintColor: .orange))
        
        aboutApp.append(AboutApp(rowIcon: "gear", rowLabel: "Version", rowContent: "1.0", rowTintColor: .purple))
        
        aboutApp.append(AboutApp(rowIcon: "ellipsis.curlybraces", rowLabel: "Developer", rowContent: "John Doe", rowTintColor: .mint))
        
        aboutApp.append(AboutApp(rowIcon: "paintpalette", rowLabel: "Designer", rowContent: "Robert Petras", rowTintColor: .pink))
        
        aboutApp.append(AboutApp(rowIcon: "globe", rowLabel: "Website", rowContent: "https://credo.academy", rowTintColor: .pink, rowLink: "Credo Academy", rowLinkDestination: URL(string: "https://credo.academy")!))

        return aboutApp
    }
}


struct CustomHikingButtonView: View {
    
    @State private var isShowModalSheet: Bool = false
    
    var body: some View {
       
        Button {
            
            isShowModalSheet.toggle()
            
            
        } label: {
            ZStack {
                Circle()
                    .fill(LinearGradient(colors: [Color.colorGreenLight, Color.colorGreenMedium], startPoint: .top, endPoint: .bottom))
                    .frame(width: 60, height: 60)
                    .overlay(
                        Circle()
                            .stroke(Color.gray, lineWidth: 2)
                    )
                
                Image(systemName: "figure.hiking")
                    .resize()
                    .foregroundStyle(.colorGrayLight)
                    .frame(width: 40, height: 40)
            }
        }
        .sheet(isPresented: $isShowModalSheet) {
            SettingsView()
                .presentationDragIndicator(.visible)
                .presentationDetents([.medium, .large])
        }
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    CustomHikingButtonView()
}
