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
                ZStack(alignment: .bottomLeading) {
                    // Background Image with rounded bottom corners
                    Image("Shimla")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: 420)
                        .clipShape(RoundedCorner(radius: 40, corners: [.bottomLeft, .bottomRight]))
                        .shadow(color: .black.opacity(0.25), radius: 10, x: 0, y: 4)
                        .edgesIgnoringSafeArea(.top)
                        .overlay(
                            // Dark gradient overlay
                            LinearGradient(
                                gradient: Gradient(colors: [Color.black.opacity(0.0), Color.black.opacity(0.4)]),
                                startPoint: .center,
                                endPoint: .bottom
                            )
                        )

                    // Title Text on image
                    VStack(alignment: .leading, spacing: 6) {
                        Text("Lesgo")
                            .font(.system(size: 36, weight: .bold))
                            .foregroundColor(.white)
                            .shadow(color: .black.opacity(0.8), radius: 6, x: 0, y: 2)
                        Text("Sign In")
                            .font(.title2.weight(.semibold))
                            .foregroundColor(.white)
                            .shadow(color: .black.opacity(0.6), radius: 4, x: 0, y: 1)
                    }
                    .padding(.leading, 24)
                    .padding(.bottom, 40)
                }

                
                // Error Message
                if !viewModel.errorMessage.isEmpty {
                    Text(viewModel.errorMessage)
                        .foregroundColor(.red)
                        .padding(.top, 10)
                }
                
                // Sign In Buttons
                VStack(spacing: 20) {
                    SignInButton(
                        icon: "globe",
                        text: "Sign In with Google",
                        textColor: .white,
                        backgroundGradient: [Color.blue, Color.pink]) {
                            // Google sign-in logic
                        }

                    SignInButton(
                        icon: "apple.logo",
                        text: "Sign In with Apple ID",
                        textColor: .white,
                        backgroundGradient: [Color.black, Color.gray]) {
                            // Apple sign-in logic
                        }

                    SignInButton(
                        icon: "bolt.fill",
                        text: "Test Login",
                        textColor: .white,
                        backgroundGradient: [Color.red]) {
                            authManager.isAuthenticated = true
                        }
                }
                .padding(.horizontal, 24)
                .padding(.top, 40)
                
                // Forgot Password
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

// More Attractive Sign In Button
struct SignInButton: View {
    let icon: String
    let text: String
    let textColor: Color
    let backgroundGradient: [Color]
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 12) {
                Image(systemName: icon)
                    .foregroundColor(textColor)
                    .font(.system(size: 20, weight: .semibold))
                
                Text(text)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(textColor)
            }
            .frame(maxWidth: .infinity)
            .frame(height: 56)
            .background(
                LinearGradient(colors: backgroundGradient, startPoint: .topLeading, endPoint: .bottomTrailing)
            )
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .shadow(color: Color.black.opacity(0.1), radius: 8, x: 0, y: 4)
            .scaleEffect(1.02)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

// Utility for Custom Rounded Corners
struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect,
                                byRoundingCorners: corners,
                                cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

// Preview
struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .environmentObject(AuthenticationManager())
    }
}
