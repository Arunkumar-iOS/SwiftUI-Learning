//
//  SettingsView.swift
//  Hike
//
//  Created by Arunkumar on 25/06/25.
//

import SwiftUI


struct GradientViewModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundStyle(
                LinearGradient(gradient: Gradient(colors: [.colorGreenLight, .colorGreenMedium, .colorGreenDark]), startPoint: .top, endPoint: .bottom)
            )
            
    }
}

extension View {
    
    func gradientModifier() -> some View {
        self.modifier(GradientViewModifier())
    }
}

struct SettingsView: View {
    
    private let alternateAppIcons: [String] = [
      "AppIcon-MagnifyingGlass",
      "AppIcon-Map",
      "AppIcon-Mushroom",
      "AppIcon-Camera",
      "AppIcon-Backpack",
      "AppIcon-Campfire"
    ]
    
    
    var body: some View {
        List {
            // MARK: - HEADER
            Section {
                VStack(spacing: 10) {
                    Group {
                        HStack {
                            Image(systemName: "laurel.leading")
                                .font(.system(size: 80, weight: .black))
                            
                            VStack(spacing: -10) {
                                Text("Hike")
                                    .font(.system(size: 66, weight: .black))
                                Text("Editor's Choice")
                                    .fontWeight(.medium)
                            }
                            
                            Image(systemName: "laurel.trailing")
                                .font(.system(size: 80, weight: .black))
                        }
                    }
                    .gradientModifier()
                    
                    Text("Where can you find \nperfect tracks?")
                        .font(.title2)
                        .fontWeight(.heavy)
                        .multilineTextAlignment(.center)
                        .padding(.top, 5)
                    
                    Text("The hike which looks gorgeous in photos but is even better once you are actually there. The hike that you hope to do again someday. \nFind the best day hikes in the app.")
                        .font(.footnote)
                        .italic()
                        .multilineTextAlignment(.center)
                        .padding(.top, 1)
                        .padding(.horizontal, 40)
                    
                    Text("Dust off the boots! it's time for \na walk.")
                        .fontWeight(.heavy)
                        .multilineTextAlignment(.center)
                        .padding(.top, 5)
                    // .padding(.horizontal, 50)
                        .gradientModifier()
                    
                }
            }
            
            // MARK: - SECTION - ALTERNATE APP ICONS
            Section(header: Text("Alternate Icons")) {
                VStack {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 12) {
                            ForEach(alternateAppIcons.indices, id: \.self) { item in
                                Button {
                                    print("Icon \(alternateAppIcons[item]) was pressed.")
                                    
                                    //To change the icons at runtime.
                                    // Add appicon images in BuildSetting->Alternate AppIcon Set -> add all alternate app icons.
                                    UIApplication.shared.setAlternateIconName(alternateAppIcons[item]) { error in
                                        if error != nil {
                                            print("Failed request to update the app's icon: \(String(describing: error?.localizedDescription))")
                                        } else {
                                            print("Success! You have changed the app's icon to \(alternateAppIcons[item])")
                                        }
                                    }
                                } label: {
                                    Image("\(alternateAppIcons[item])-Preview")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 80, height: 80)
                                        .cornerRadius(16)
                                }
                                .buttonStyle(.borderless)
                            }
                        }
                    } //: SCROLL VIEW
                    .padding(.top, 12)
                    
                    Text("Choose your favourite app icon from the collection above.")
                        .foregroundStyle(.colorGrayLight)
                        .multilineTextAlignment(.center)
                        .padding(.vertical, 16)
                }
                
            }
            
            // MARK: - FOOTER
            Section(
                header: Text("ABOUT THE APP"),
                footer: HStack {
                    Spacer()
                    Text("Copyright © All rights reserved.")
                    Spacer()
                }
                    .padding(.vertical, 10)
            ) {
                ForEach(AboutAppStore.getAboutAppStore(), id: \.self) { about in
                    
                    SettingsRowView(about: about)
                }
            }
        }
    }
}

#Preview {
    SettingsView()
}


struct SettingsRowView: View {
    var about: AboutApp
    
    var body: some View {
        HStack {
            
            LabeledContent {
                //Check for the website link and navigate the user.
                //Content
                if let webSiteLink = about.rowLinkDestination, let webContent = about.rowLink {
                    Link(destination: webSiteLink) {
                        Text("\(webContent)")
                            .foregroundStyle(.pink)
                            .fontWeight(.heavy)
                    }
                }
                else {
                    Text("\(about.rowContent)")
                        .foregroundStyle(.primary)
                        .fontWeight(.heavy)
                }
                
            } label: {
                //Label
                HStack {
                    ZStack {
                        RoundedRectangle(cornerRadius: 12)
                            .fill(about.rowTintColor)
                            .frame(width: 40, height: 40)
                        Image(systemName: about.rowIcon)
                            .foregroundStyle(.white)
                    }
                    
                    Text(about.rowLabel)
                        .fontWeight(.medium)
                }
            }
            
            /*
            Image(systemName: about.imageName)
                .resize()
                .frame(width: 30, height: 30)
                .foregroundStyle(.blue)
                
            Text(about.appName)
                .fontWeight(.bold)
            Spacer()
            Text("\(about.appDescription)")
             */
        }
    }
}
