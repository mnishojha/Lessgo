//
//  ContentViewModel.swift
//  Lessgo
//
//

import FirebaseAuth
import Firebase
import SwiftUI


class ContentViewModel: ObservableObject {
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
        // Your login logic here
    }
    
    func signUpUser() {
        guard !email.isEmpty, !password.isEmpty else {
            errorMessage = "Email and password are required."
            return
        }

        // Create user in Firebase Auth
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] authResult, error in
            guard let self = self else { return }
            
            if let error = error {
                self.errorMessage = "Error: \(error.localizedDescription)"
                return
            }

            guard let userId = authResult?.user.uid else {
                self.errorMessage = "Unable to retrieve user ID."
                return
            }

            // Save data to Firestore
            self.saveUserProfileData(userId: userId)
        }
    }

    private func saveUserProfileData(userId: String) {
        let db = Firestore.firestore()

        // Gather all data
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

        // Save to Firestore
        db.collection("users").document(userId).setData(userData) { error in
            if let error = error {
                self.errorMessage = "Failed to save profile: \(error.localizedDescription)"
            } else {
                self.errorMessage = "Profile saved successfully!"
            }
        }
    }
}
