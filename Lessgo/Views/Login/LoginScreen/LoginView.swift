import SwiftUI
import FirebaseAuth
import Firebase

struct LoginView: View {
    @StateObject private var viewModel = ContentViewModel()
    @EnvironmentObject private var authManager: AuthenticationManager
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                // Header Image Section
                Image("Shimla")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 380)
                    .clipShape(RoundedRectangle(cornerRadius: 40))
                    .edgesIgnoringSafeArea(.top)
                
                // Title
                VStack(spacing: 8) {
                    Text("Lesgo")
                        .font(.largeTitle.bold())
                        .foregroundColor(.white)
                    Text("Sign In")
                        .font(.title2)
                        .foregroundColor(.white)
                }
                .padding(.bottom, 20)
                
                // Error Message
                if !viewModel.errorMessage.isEmpty {
                    Text(viewModel.errorMessage)
                        .foregroundColor(.red)
                        .padding(.top, 10)
                }
                
                // Sign In Buttons
                VStack(spacing: 20) {
                    SignInButton(icon: "globe", text: "Sign In with Google", textColor: .black, backgroundColor: .gray.opacity(0.2)) {
                        // Add Google sign-in logic
                    }
                    
                    SignInButton(icon: "apple.logo", text: "Sign In with Apple ID", textColor: .black, backgroundColor: .gray.opacity(0.2)) {
                        // Add Apple sign-in logic
                    }
                    
                    SignInButton(icon: "bolt.fill", text: "Test Login", textColor: .white, backgroundColor: .red.opacity(0.7)) {
                        authManager.isAuthenticated = true
                    }
                }
                .padding(.horizontal, 24)
                .padding(.top, 40)
                
                // Forgot Password Button
                Button(action: {
                    // Forgot password logic
                }) {
                    Text("Forgot Password?")
                        .foregroundColor(.gray)
                        .underline()
                }
                .padding(.top, 20)
                
                Spacer()
                
                // Footer Sign Up
                NavigationLink(destination: SignUpFlowView(viewModel: viewModel)) {
                    HStack(spacing: 4) {
                        Text("Don't have an account?")
                            .foregroundColor(.gray)
                        Text("Sign Up")
                            .fontWeight(.semibold)
                            .foregroundColor(.blue)
                    }
                }
                .padding(.bottom, 32)
            }
           
        }
    }
}

// Sign In Button Component
struct SignInButton: View {
    let icon: String
    let text: String
    let textColor: Color
    let backgroundColor: Color
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 12) {
                Image(systemName: icon)
                    .foregroundColor(textColor)
                    .font(.system(size: 20))
                
                Text(text)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(textColor)
            }
            .frame(maxWidth: .infinity)
            .frame(height: 56)
            .background(backgroundColor)
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .shadow(color: Color.black.opacity(0.05), radius: 10, x: 0, y: 5)
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .environmentObject(AuthenticationManager())
    }
}
