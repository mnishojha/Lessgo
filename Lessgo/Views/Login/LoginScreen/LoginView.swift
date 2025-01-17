import SwiftUI
import FirebaseAuth
import Firebase

struct LoginView: View {
    @StateObject private var viewModel = ContentViewModel()
    @EnvironmentObject private var authManager: AuthenticationManager
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Header Image Section
                ZStack {
                    GeometryReader { geometry in
                        Image("Shimla")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: geometry.size.width, height: geometry.size.height + 50)
                            .clipShape(
                                RoundedCornersShape(
                                    corners: [.bottomLeft, .bottomRight],
                                    radius: 40
                                )
                            )
                            .edgesIgnoringSafeArea(.top)
                    }
                    .frame(height: 380)

                    // Logo and text overlay
                    VStack(spacing: 16) {
                        Spacer()
                        Text("Lesgo")
                            .font(.system(size: 40, weight: .bold))
                            .foregroundColor(.white)
                            .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: 2)

                        Text("Sign In")
                            .font(.system(size: 28, weight: .semibold))
                            .foregroundColor(.white)
                            .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: 2)
                        
                        Spacer()
                    }
                    .padding(.bottom, 30)
                }
                
                // Error Message
                if !viewModel.errorMessage.isEmpty {
                    Text(viewModel.errorMessage)
                        .foregroundColor(.red)
                        .padding(.top, 10)
                }
                
                // Sign In Buttons
                VStack(spacing: 20) {
                    // Google Sign In Button
                    SignInButton(
                        customIcon: "google",
                        text: "Sign In with Google",
                        textColor: .black,
                        backgroundColor: Color(.systemGray6)
                    ) {
                        // Add Google sign in logic
                    }

                    // Apple Sign In Button
                    SignInButton(
                        icon: "apple.logo",
                        text: "Sign In with Apple ID",
                        textColor: .black,
                        backgroundColor: Color(.systemGray6)
                    ) {
                        // Add Apple sign in logic
                    }
                    
                    // Test Login Button
                    SignInButton(
                        icon: "bolt.fill",
                        text: "Test Login",
                        textColor: .white,
                        backgroundColor: .red.opacity(0.7)
                    ) {
                        // Direct authentication for testing
                        authManager.isAuthenticated = true
                    }
                }
                .padding(.horizontal, 24)
                .padding(.top, 40)
                
                // Forgot Password Button
                forgotPasswordButton
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
            .background(Color(.systemBackground))
        }
    }
    
    var forgotPasswordButton: some View {
        Button(action: {
            // Add your forgot password logic here
        }) {
            Text("Forgot Password?")
                .foregroundColor(.gray)
                .underline()
        }
    }
}

// Custom Shape for rounded corners
struct RoundedCornersShape: Shape {
    let corners: UIRectCorner
    let radius: CGFloat
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}

// SignInButton Component
struct SignInButton: View {
    let icon: String?
    let customIcon: String?
    let text: String
    let textColor: Color
    let backgroundColor: Color
    let action: () -> Void
    
    init(
        icon: String? = nil,
        customIcon: String? = nil,
        text: String,
        textColor: Color,
        backgroundColor: Color,
        action: @escaping () -> Void
    ) {
        self.icon = icon
        self.customIcon = customIcon
        self.text = text
        self.textColor = textColor
        self.backgroundColor = backgroundColor
        self.action = action
    }
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 12) {
                if let systemIcon = icon {
                    Image(systemName: systemIcon)
                        .foregroundColor(textColor)
                        .font(.system(size: 20))
                } else if let custom = customIcon {
                    Image(custom)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24, height: 24)
                }
                
                Text(text)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(textColor)
            }
            .frame(maxWidth: .infinity)
            .frame(height: 56)
            .background(backgroundColor)
            .cornerRadius(16)
            .shadow(color: Color.black.opacity(0.05), radius: 10, x: 0, y: 5)
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
