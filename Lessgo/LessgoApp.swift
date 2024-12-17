//
//  LessgoApp.swift
//  Lessgo
//
//  Created by manish ojha on 18/10/24.
//

import SwiftUI
import Firebase

@main
struct LessgoApp: App {
    @StateObject private var authManager = AuthenticationManager()
    
    init() {
        // Add error handling for Firebase configuration
        do {
            if FirebaseApp.app() == nil {
                if Bundle.main.path(forResource: "GoogleService-Info", ofType: "plist") != nil {
                    FirebaseApp.configure()
                } else {
                    print("Error: Firebase configuration file not found")
                }
            }
        }
    }
    
    var body: some Scene {
        WindowGroup {
            if authManager.isAuthenticated {
                MainTabView()
                    .environmentObject(authManager)
            } else {
                LoginView()
                    .environmentObject(authManager)
            }
        }
    }
}
