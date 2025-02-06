//
//  ContentViewModel.swift
//  Lessgo
//
//  Created by manish ojha on 06/02/25.
//

import Foundation
import FirebaseAuth
import Firebase
import SwiftUI

class ContentViewModels: ObservableObject {
    @Published var isAuthenticated = false
    @Published var photos: [Data?] = [nil, nil, nil]
    @Published var email = ""
    @Published var password = ""
    @Published var errorMessage = ""
    @Published var isLoginButtonPressed = false
    @Published var isSignUpButtonPressed = false
    @Published var showPassword = false
    @Published var languages: [String] = []
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
            "photos": photos.compactMap { $0?.base64EncodedString() }
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
