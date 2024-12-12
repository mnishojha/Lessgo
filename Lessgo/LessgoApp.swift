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
        FirebaseApp.configure()
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
