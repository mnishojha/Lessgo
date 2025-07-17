//
//  LoginViewViewModel.swift
//  Lessgo
//
//  Created by manish ojha on 13/06/25.
//
import GoogleSignIn
import Foundation
import FirebaseAuth

class LoginViewViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var errorMessage: String = ""
    
    func login(authManager: AuthenticationManager) {
        // Clear previous errors
        errorMessage = ""
        
        // Validate input
        guard !email.isEmpty, !password.isEmpty else {
            errorMessage = "Please enter both email and password."
            return
        }

        // Attempt Firebase sign-in
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            DispatchQueue.main.async {
                if let error = error {
                    self.errorMessage = error.localizedDescription
                } else {
                    authManager.isAuthenticated = true
                }
            }
        }
    }
}


