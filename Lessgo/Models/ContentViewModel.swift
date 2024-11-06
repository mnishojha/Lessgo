//
//  ContentViewModel.swift
//  Lessgo
//
//

import FirebaseAuth
import Firebase
import SwiftUI


class ContentViewModel: ObservableObject{
    
    @Published var email = ""
    @Published var password = ""
    @Published var errorMessage = ""
    @Published var isLoginButtonPressed = false
    @Published var isSignUpButtonPressed = false
    @Published var showPassword = false
    
    func loginUser() {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] result, error in
            if let error = error {
                self?.errorMessage = "Error: \(error.localizedDescription)"
            } else {
                self?.errorMessage = ""
            }
        }
    }
    
    func signUpUser() {
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] result, error in
            if let error = error {
                self?.errorMessage = "Error: \(error.localizedDescription)"
            } else {
                self?.errorMessage = ""
                self?.saveUserProfileData()
            }
        }
    }
    
    private func saveUserProfileData() {
          guard let userID = Auth.auth().currentUser?.uid else { return }
          
          Firestore.firestore().collection("users").document(userID).setData([
              "email": email,
              "dateOfBirth": "", // Populate with actual data from Dateofbirth view
              "interests": "",   // Populate with actual data from InterestView
              "language": "",    // Populate with actual data from LanguageView
              "location": ""     // Populate with actual data from LocationView
          ]) { [weak self] error in
              if let error = error {
                  self?.errorMessage = "Error saving data: \(error.localizedDescription)"
              }
          }
      }
    
}


