//
//  SettingView.swift
//  Lessgo
//
//  Created by manish ojha on 17/12/24.
//

import SwiftUI

struct SettingsView: View {
    @State private var notificationsEnabled = true
    @State private var selectedLanguage = "English"
    
    let languages = ["English", "Spanish", "French", "German"]
    
    var body: some View {
        NavigationView {
            Form {
            
                Section(header: Text("Account")) {
                    NavigationLink(destination: Text("Profile Details")) {
                        HStack {
                            Image(systemName: "person.circle")
                                .foregroundColor(.blue)
                            Text("Profile")
                        }
                    }
                    
                    NavigationLink(destination: Text("Change Password")) {
                        HStack {
                            Image(systemName: "key.fill")
                                .foregroundColor(.orange)
                            Text("Change Password")
                        }
                    }
                }
                
    
                Section(header: Text("Preferences")) {
                    Toggle(isOn: $notificationsEnabled) {
                        HStack {
                            Image(systemName: "bell.fill")
                                .foregroundColor(.green)
                            Text("Notifications")
                        }
                    }
                    
                    Picker(selection: $selectedLanguage, label: Text("Language")) {
                        ForEach(languages, id: \.self) { language in
                            Text(language)
                        }
                    }
                }
                
          
                Section(header: Text("About")) {
                    NavigationLink(destination: Text("Version 1.0.0")) {
                        HStack {
                            Image(systemName: "info.circle.fill")
                                .foregroundColor(.blue)
                            Text("App Version")
                        }
                    }
                    
                    NavigationLink(destination: Text("Lessgo is a travel app that connects you with like-minded travel companions. Happy travels!")) {
                        HStack {
                            Image(systemName: "star.fill")
                                .foregroundColor(.yellow)
                            Text("About Lessgo")
                        }
                    }
                }
                
              
                Section(header: Text("Support")) {
                    NavigationLink(destination: Text("FAQs")) {
                        HStack {
                            Image(systemName: "questionmark.circle.fill")
                                .foregroundColor(.gray)
                            Text("FAQs")
                        }
                    }
                    
                    NavigationLink(destination: Text("Contact Us")) {
                        HStack {
                            Image(systemName: "envelope.fill")
                                .foregroundColor(.red)
                            Text("Contact Us")
                        }
                    }
                }
                
             
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
                    }
                }
            }
            .navigationBarTitle("Settings", displayMode: .inline)
            .preferredColorScheme(.dark) // Force Dark Mode
        }
    }
}


struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView().preferredColorScheme(.dark)
    }
}
