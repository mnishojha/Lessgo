import SwiftUI
import FirebaseAuth
import Firebase

struct LoginView: View {
    @StateObject private var viewModel = ContentViewModel()
    @State private var isEmailFocused = false
    @State private var isPasswordFocused = false
    
    var body: some View {
        NavigationView {  // Wrap everything in NavigationView
            ZStack {
                Color.black.edgesIgnoringSafeArea(.all)
                
                VStack(spacing: 30) {
                    logoView
                    
                    VStack(spacing: 20) {
                        CustomTextField(text: $viewModel.email, placeholder: "Email", isFocused: $isEmailFocused)
                        CustomSecureField(text: $viewModel.password, placeholder: "Password", isFocused: $isPasswordFocused, showPassword: $viewModel.showPassword)
                    }
                    .padding(.horizontal, 20)
                    
                    Text(viewModel.errorMessage)
                        .foregroundColor(.red)
                    
                    loginButton
                    signUpButton // Ensure this is the NavigationLink we’ll use for SignUpFlowView
                    forgotPasswordButton
                }
            }
        }
    }
    
    var logoView: some View {
        Text("LESSGO")
            .font(.system(size: 40, weight: .bold, design: .rounded))
            .foregroundColor(.white)
            .padding(.top, 50)
    }
    var loginButton: some View {
        Button(action: {
            viewModel.isLoginButtonPressed.toggle()
            viewModel.loginUser()
        }) {
            Text("Log In")
                .font(.headline)
                .foregroundColor(.black)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.white)
                .cornerRadius(10)
                .scaleEffect(viewModel.isLoginButtonPressed ? 0.95 : 1)
        }
        .padding(.horizontal, 20)
    }

    var signUpButton: some View {
        NavigationLink(destination: SignUpFlowView(viewModel: viewModel)) {
            Text("Sign Up")
                .font(.headline)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.blue)
                .cornerRadius(10)
        }
        .padding(.horizontal, 20)
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




struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
