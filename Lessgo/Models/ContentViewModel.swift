//
//  ContentViewModel.swift
//  Lessgo
//
//

import FirebaseAuth
import Firebase
import SwiftUI


class ContentViewModel: ObservableObject {
    @Published var isAuthenticated = false
    
    // Basic fields
    @Published var photos: [UIImage?] = [nil, nil, nil] // Initialize with empty placeholders
    @Published var email = ""
    @Published var password = ""
    @Published var errorMessage = ""
    @Published var isLoginButtonPressed = false
    @Published var isSignUpButtonPressed = false
    @Published var showPassword = false
    @Published var languages: [String] = []
    
    // Additional information fields
    @Published var dateOfBirth = Date()
    @Published var location = ""
    @Published var interests = [String]()
    @Published var language = ""
    @Published var upcomingTrip = ""
    @Published var topPick = ""
    
    func loginUser() {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] result, error in
            guard let self = self else { return }
            
            if let error = error {
                self.errorMessage = error.localizedDescription
                return
            }
            
            // Clear sensitive data after successful login
            DispatchQueue.main.async {
                self.password = ""
                self.errorMessage = ""
            }
        }
    }
    
    func signUpUser(completion: @escaping (Bool) -> Void = { _ in }) {
        guard !email.isEmpty, !password.isEmpty else {
            errorMessage = "Email and password are required."
            completion(false)
            return
        }

        Auth.auth().createUser(withEmail: email, password: password) { [weak self] authResult, error in
            guard let self = self else { return }
            
            if let error = error {
                DispatchQueue.main.async {
                    self.errorMessage = "Error: \(error.localizedDescription)"
                    completion(false)
                }
                return
            }

            guard let userId = authResult?.user.uid else {
                DispatchQueue.main.async {
                    self.errorMessage = "Unable to retrieve user ID."
                    completion(false)
                }
                return
            }

            self.saveUserProfileData(userId: userId) { success in
                if success {
                    // Auto login after successful signup
                    self.loginUser()
                    completion(true)
                } else {
                    completion(false)
                }
            }
        }
    }

    private func saveUserProfileData(userId: String, completion: @escaping (Bool) -> Void) {
        let db = Firestore.firestore()

        let userData: [String: Any] = [
            "email": email,
            "dateOfBirth": dateOfBirth,
            "location": location,
            "interests": interests,
            "language": language,
            "upcomingTrip": upcomingTrip,
            "topPick": topPick,
            "languages": languages,
            "photos": photos.compactMap { $0?.jpegData(compressionQuality: 0.8)?.base64EncodedString() }
        ]

        db.collection("users").document(userId).setData(userData) { error in
            if let error = error {
                self.errorMessage = "Failed to save profile: \(error.localizedDescription)"
                completion(false)
            } else {
                self.errorMessage = "Profile saved successfully!"
                completion(true)
            }
        }
    }
}
