//
//  SettingsView.swift
//  Lessgo
//
//  Created by Manish Ojha on 17/12/24.
//

import SwiftUI

struct SettingsView: View {
    @State private var notificationsEnabled = true
    @State private var selectedLanguage = "English"
    
    let languages = ["English", "Spanish", "French", "German"]
    
    var body: some View {
        NavigationView {
            Form {
                // Account Section
                Section(header: Text("Account").textCase(nil)) {
                    NavigationLink(destination: Text("Profile Details")) {
                        Label("Profile", systemImage: "person.circle")
                            .foregroundColor(.blue)
                    }
                    
                    NavigationLink(destination: Text("Change Password")) {
                        Label("Change Password", systemImage: "key.fill")
                            .foregroundColor(.orange)
                    }
                }
                
                // Preferences Section
                Section(header: Text("Preferences").textCase(nil)) {
                    Toggle(isOn: $notificationsEnabled) {
                        Label("Notifications", systemImage: "bell.fill")
                            .foregroundColor(.green)
                    }
                    
                    Picker("Language", selection: $selectedLanguage) {
                        ForEach(languages, id: \.self) { language in
                            Text(language)
                        }
                    }
                }
                
                // About Section
                Section(header: Text("About").textCase(nil)) {
                    NavigationLink(destination: Text("Version 1.0.0")) {
                        Label("App Version", systemImage: "info.circle.fill")
                            .foregroundColor(.blue)
                    }
                    
                    NavigationLink(destination: Text("Lessgo is a travel app that connects you with like-minded travel companions. Happy travels!")) {
                        Label("About Lessgo", systemImage: "star.fill")
                            .foregroundColor(.yellow)
                    }
                }
                
                // Support Section
                Section(header: Text("Support").textCase(nil)) {
                    NavigationLink(destination: Text("FAQs")) {
                        Label("FAQs", systemImage: "questionmark.circle.fill")
                            .foregroundColor(.gray)
                    }
                    
                    NavigationLink(destination: Text("Contact Us")) {
                        Label("Contact Us", systemImage: "envelope.fill")
                            .foregroundColor(.red)
                    }
                }
                
                // Log Out Button
                Section {
                    Button(action: {
                        print("Logged out")
                    }) {
                        HStack {
                            Image(systemName: "power")
                                .foregroundColor(.red)
                            Text("Log Out")
                                .foregroundColor(.red)
                        }
                        .frame(maxWidth: .infinity, alignment: .center)
                    }
                }
            }
           
        }
    }
}

// Preview
struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView().preferredColorScheme(.dark)
    }
}
