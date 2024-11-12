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
        // Your sign-up logic here
    }
    
    private func saveUserProfileData() {
        // Your Firestore saving logic here, including the additional fields
    }
}
