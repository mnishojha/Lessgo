import SwiftUI
import FirebaseAuth

class AuthenticationManager: ObservableObject {
    @Published var isAuthenticated = false
    
    init() {
        // Check if user is already logged in
        Auth.auth().addStateDidChangeListener { [weak self] _, user in
            self?.isAuthenticated = user != nil
        }
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
            // isAuthenticated will automatically update due to the auth state listener
        } catch {
            print("Error signing out: \(error.localizedDescription)")
        }
    }
} 