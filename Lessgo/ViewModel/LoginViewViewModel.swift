//
//  LoginViewViewModel.swift
//  Lessgo
//
//  Created by manish ojha on 07/11/24.
//


import Foundation

class LoginViewViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    
    init() {}
     
    func login() {
        guard validateFields() else {
            print("Validation failed")
            return
        }
        
        // Perform login (e.g., call API or authentication logic)
        print("Logging in with email: \(email) and password: \(password)")
    }
    
    // Function to validate the email and password fields
    private func validateFields() -> Bool {
        return validateEmail() && validatePassword()
    }
    
    // Email validation logic
    private func validateEmail() -> Bool {
        // Trim whitespaces and check if the email is valid using regex or another logic
        let email = email.trimmingCharacters(in: .whitespaces) // Corrected 'whitespace' to 'whitespaces'
        guard !email.isEmpty, isValidEmail(email) else {
            print("Invalid email")
            return false
        }
        return true
    }
    
    // Password validation logic
    private func validatePassword() -> Bool {
        // Check if password is not empty and meets your security criteria (e.g., length)
        let password = password.trimmingCharacters(in: .whitespaces) // Corrected 'whitespace' to 'whitespaces'
        guard !password.isEmpty, password.count >= 6 else {
            print("Password must be at least 6 characters")
            return false
        }
        return true
    }
    
   
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailPredicate.evaluate(with: email)
    }
}
