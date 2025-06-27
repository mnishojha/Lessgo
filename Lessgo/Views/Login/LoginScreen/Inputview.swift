//
//  Inputview.swift
//  Lessgo
//
//  Created by manish ojha on 26/06/25.
//

import SwiftUI
import FirebaseAuth

// MARK: - Input Field Types
enum InputFieldType {
    case fullName, email, availability, password, confirmPassword
    
    var placeholder: String {
        switch self {
        case .fullName: return "Full Name"
        case .email: return "Email Address"
        case .availability: return "Availability"
        case .password: return "Password"
        case .confirmPassword: return "Confirm Password"
        }
    }
    
    var keyboardType: UIKeyboardType {
        switch self {
        case .email: return .emailAddress
        default: return .default
        }
    }
    
    var isSecure: Bool {
        return self == .password || self == .confirmPassword
    }
}

// MARK: - Custom Input Field Component
struct CustomInputField: View {
    let type: InputFieldType
    @Binding var text: String
    @State private var isPasswordVisible = false
    
    var body: some View {
        HStack {
            if type.isSecure && !isPasswordVisible {
                SecureField(type.placeholder, text: $text)
            } else {
                TextField(type.placeholder, text: $text)
                    .keyboardType(type.keyboardType)
                    .autocapitalization(type == .email ? .none : .words)
                    .disableAutocorrection(type == .email)
            }
            
            if type.isSecure {
                Button(action: { isPasswordVisible.toggle() }) {
                    Image(systemName: isPasswordVisible ? "eye.slash" : "eye")
                        .foregroundColor(.gray)
                }
            }
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.gray.opacity(0.3), lineWidth: 1)
        )
    }
}

// MARK: - Social Login Button Component
struct SocialLoginButton: View {
    let provider: SocialProvider
    let action: () -> Void
    
    enum SocialProvider {
        case facebook, google, apple
        
        var iconName: String {
            switch self {
            case .facebook: return "f.circle.fill"
            case .google: return "g.circle.fill"
            case .apple: return "apple.logo"
            }
        }
        
        var color: Color {
            switch self {
            case .facebook: return .blue
            case .google: return .red
            case .apple: return .black
            }
        }
    }
    
    var body: some View {
        Button(action: action) {
            Image(systemName: provider.iconName)
                .resizable()
                .frame(width: 32, height: 32)
                .foregroundColor(provider.color)
        }
        .padding(8)
        .background(Color.white)
        .clipShape(Circle())
        .shadow(color: .gray.opacity(0.3), radius: 2, x: 0, y: 1)
    }
}

// MARK: - Form Validation
struct FormValidator {
    static func validateEmail(_ email: String) -> String? {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email) ? nil : "Please enter a valid email address"
    }
    
    static func validatePassword(_ password: String) -> String? {
        if password.count < 6 {
            return "Password must be at least 6 characters long"
        }
        return nil
    }
    
    static func validateFullName(_ name: String) -> String? {
        return name.trimmingCharacters(in: .whitespacesAndNewlines).count < 2 ? "Please enter your full name" : nil
    }
    
    static func validatePasswordMatch(_ password: String, _ confirmPassword: String) -> String? {
        return password != confirmPassword ? "Passwords do not match" : nil
    }
}

// MARK: - Main Signup View
struct SignupView: View {
    @State private var fullName = ""
    @State private var emailOrPhone = ""
    @State private var availability = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var rememberMe = false
    @State private var errorMessage = ""
    @State private var isLoading = false
    @State private var isSignedUp = false
    @State private var showingAlert = false
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 24) {
                    headerSection
                    formSection
                    rememberMeSection
                    errorSection
                    signupButton
                    socialLoginSection
                    loginRedirectSection
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 40)
            }
            .background(Color(.systemBackground))
            .navigationBarHidden(true)
            .alert("Success", isPresented: $showingAlert) {
                Button("OK") {
                    isSignedUp = true
                }
            } message: {
                Text("Account created successfully!")
            }
            .navigationDestination(isPresented: $isSignedUp) {
                LoggedInView()
            }
        }
    }
    
    // MARK: - View Components
    private var headerSection: some View {
        VStack(spacing: 8) {
            Text("Create Account")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.primary)
            
            Text("Join us and start your journey")
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
    }
    
    private var formSection: some View {
        VStack(spacing: 16) {
            CustomInputField(type: .fullName, text: $fullName)
            CustomInputField(type: .email, text: $emailOrPhone)
            CustomInputField(type: .availability, text: $availability)
            CustomInputField(type: .password, text: $password)
            CustomInputField(type: .confirmPassword, text: $confirmPassword)
        }
    }
    
    private var rememberMeSection: some View {
        HStack {
            Toggle(isOn: $rememberMe) {
                Text("Remember me")
                    .font(.subheadline)
                    .foregroundColor(.primary)
            }
            .toggleStyle(SwitchToggleStyle(tint: .purple))
            Spacer()
        }
    }
    
    private var errorSection: some View {
        Group {
            if !errorMessage.isEmpty {
                HStack {
                    Image(systemName: "exclamationmark.triangle.fill")
                        .foregroundColor(.red)
                    Text(errorMessage)
                        .font(.caption)
                        .foregroundColor(.red)
                    Spacer()
                }
                .padding(.horizontal, 4)
            }
        }
    }
    
    private var signupButton: some View {
        Button(action: signUp) {
            HStack {
                if isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        .scaleEffect(0.8)
                } else {
                    Text("Create Account")
                        .font(.headline)
                        .fontWeight(.semibold)
                }
            }
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .frame(height: 56)
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [Color.purple, Color.purple.opacity(0.8)]),
                    startPoint: .leading,
                    endPoint: .trailing
                )
            )
            .cornerRadius(16)
            .shadow(color: .purple.opacity(0.3), radius: 8, x: 0, y: 4)
        }
        .disabled(isLoading)
        .scaleEffect(isLoading ? 0.95 : 1.0)
        .animation(.easeInOut(duration: 0.1), value: isLoading)
    }
    
    private var socialLoginSection: some View {
        VStack(spacing: 16) {
            HStack {
                Rectangle()
                    .frame(height: 1)
                    .foregroundColor(.gray.opacity(0.3))
                
                Text("Or continue with")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .padding(.horizontal, 16)
                
                Rectangle()
                    .frame(height: 1)
                    .foregroundColor(.gray.opacity(0.3))
            }
            
            HStack(spacing: 24) {
                SocialLoginButton(provider: .facebook) {
                    handleSocialLogin(.facebook)
                }
                
                SocialLoginButton(provider: .google) {
                    handleSocialLogin(.google)
                }
                
                SocialLoginButton(provider: .apple) {
                    handleSocialLogin(.apple)
                }
            }
        }
    }
    
    private var loginRedirectSection: some View {
        HStack {
            Text("Already have an account?")
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            NavigationLink(destination: SimpleLoginView()) {
                Text("Sign In")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(.purple)
            }
        }
    }
    
    // MARK: - Actions
    private func signUp() {
        // Clear previous errors
        errorMessage = ""
        
        // Validate inputs
        if let nameError = FormValidator.validateFullName(fullName) {
            errorMessage = nameError
            return
        }
        
        if let emailError = FormValidator.validateEmail(emailOrPhone) {
            errorMessage = emailError
            return
        }
        
        if let passwordError = FormValidator.validatePassword(password) {
            errorMessage = passwordError
            return
        }
        
        if let matchError = FormValidator.validatePasswordMatch(password, confirmPassword) {
            errorMessage = matchError
            return
        }
        
        // Start loading
        isLoading = true
        
        // Create user with Firebase
        Auth.auth().createUser(withEmail: emailOrPhone, password: password) { result, error in
            DispatchQueue.main.async {
                isLoading = false
                
                if let error = error {
                    errorMessage = error.localizedDescription
                } else {
                    // Update user profile with full name
                    if let user = result?.user {
                        let changeRequest = user.createProfileChangeRequest()
                        changeRequest.displayName = fullName
                        changeRequest.commitChanges { _ in
                            // Profile updated
                        }
                    }
                    
                    errorMessage = ""
                    showingAlert = true
                }
            }
        }
    }
    
    private func handleSocialLogin(_ provider: SocialLoginButton.SocialProvider) {
        // Implement social login logic here
        print("Social login with \(provider)")
        // For now, just show a placeholder message
        errorMessage = "Social login coming soon!"
    }
}

// MARK: - Supporting Views
struct SimpleLoginView: View {
    var body: some View {
        VStack(spacing: 20) {
            Text("Welcome Back!")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Text("Login Screen")
                .font(.title2)
                .foregroundColor(.secondary)
            
            Text("(To be implemented)")
                .font(.caption)
                .foregroundColor(.gray)
        }
        .padding()
        .navigationTitle("Login")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct LoggedInView: View {
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "checkmark.circle.fill")
                .resizableToFit()
                .frame(width: 80, height: 80)
                .foregroundColor(.green)
            
            Text("Welcome!")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Text("Your account has been created successfully")
                .font(.subheadline)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
        }
        .padding()
        .navigationBarBackButtonHidden(true)
    }
}

// MARK: - Preview
struct SignupView_Previews: PreviewProvider {
    static var previews: some View {
        SignupView()
    }
}

// MARK: - Extensions
extension Image {
    func resizableToFit() -> some View {
        self
            .resizable()
            .aspectRatio(contentMode: .fit)
    }
}
