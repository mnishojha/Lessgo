
import SwiftUI

struct LoginViewModel: View {
    @StateObject private var viewModel = ContentViewModel()
    @EnvironmentObject var authManager: AuthenticationManager
    
    var body: some View {
        VStack(spacing: 16) {
            TextField("Email", text: $viewModel.email)
                .textInputAutocapitalization(.none)
                .autocorrectionDisabled()
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(10)
            
            SecureField("Password", text: $viewModel.password)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(10)
            
            DatePicker("Date of Birth", selection: $viewModel.dateOfBirth, displayedComponents: .date)
                .padding()
            
            TextField("Location", text: $viewModel.location)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(10)
            
            if !viewModel.errorMessage.isEmpty {
                Text(viewModel.errorMessage)
                    .foregroundColor(.red)
                    .multilineTextAlignment(.center)
                    .padding(.top, 5)
            }
            
            Button("Sign Up") {
                viewModel.signUpUser { success in
                    if success {
                        authManager.isAuthenticated = true
                    }
                }
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
        .padding()
    }
}
