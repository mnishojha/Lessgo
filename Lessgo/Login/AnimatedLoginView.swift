import SwiftUI

struct ContentView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var isEmailFocused = false
    @State private var isPasswordFocused = false
    @State private var isLoginButtonPressed = false
    @State private var isSignUpButtonPressed = false
    @State private var showPassword = false
    
    //This is a test push for the view
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 30) {
                logoView
                
                VStack(spacing: 20) {
                    customTextField(text: $email, placeholder: "Email", isFocused: $isEmailFocused)
                    
                    customSecureField(text: $password, placeholder: "Password", isFocused: $isPasswordFocused, showPassword: $showPassword)
                }
                .padding(.horizontal, 20)
                
                loginButton
                
                signUpButton
                
                forgotPasswordButton
            }
        }
    }
    
    var logoView: some View {
        Text("LESSGO")
            .font(.system(size: 40, weight: .bold, design: .rounded))
            .foregroundColor(.white)
            .padding(.top, 50)
    }
    
    func customTextField(text: Binding<String>, placeholder: String, isFocused: Binding<Bool>) -> some View {
        ZStack(alignment: .leading) {
            if text.wrappedValue.isEmpty {
                Text(placeholder)
                    .foregroundColor(.gray)
                    .padding(.horizontal, 10)
                    .offset(y: isFocused.wrappedValue ? -25 : 0)
                    .scaleEffect(isFocused.wrappedValue ? 0.8 : 1, anchor: .leading)
            }
            
            TextField("", text: text) { focused in
                withAnimation(.easeInOut(duration: 0.2)) {
                    isFocused.wrappedValue = focused
                }
            }
            .foregroundColor(.white)
            .padding(10)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(isFocused.wrappedValue ? Color.white : Color.gray, lineWidth: 1)
            )
            .animation(.easeInOut(duration: 0.2), value: isFocused.wrappedValue)
        }
    }
    
    func customSecureField(text: Binding<String>, placeholder: String, isFocused: Binding<Bool>, showPassword: Binding<Bool>) -> some View {
        ZStack(alignment: .leading) {
            if text.wrappedValue.isEmpty {
                Text(placeholder)
                    .foregroundColor(.gray)
                    .padding(.horizontal, 10)
                    .offset(y: isFocused.wrappedValue ? -25 : 0)
                    .scaleEffect(isFocused.wrappedValue ? 0.8 : 1, anchor: .leading)
            }
            
            HStack {
                if showPassword.wrappedValue {
                    TextField("", text: text)
                } else {
                    SecureField("", text: text)
                }
                
                Button(action: {
                    showPassword.wrappedValue.toggle()
                }) {
                    Image(systemName: showPassword.wrappedValue ? "eye.slash.fill" : "eye.fill")
                        .foregroundColor(.gray)
                }
            }
            .foregroundColor(.white)
            .padding(10)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(isFocused.wrappedValue ? Color.white : Color.gray, lineWidth: 1)
            )
            .animation(.easeInOut(duration: 0.2), value: isFocused.wrappedValue)
        }
        .onTapGesture {
            withAnimation(.easeInOut(duration: 0.2)) {
                isFocused.wrappedValue = true
            }
        }
    }
    
    var loginButton: some View {
        Button(action: {
            withAnimation(.spring(response: 0.3, dampingFraction: 0.6, blendDuration: 0)) {
                isLoginButtonPressed.toggle()
            }
            
            // Add your login logic here
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                withAnimation(.spring(response: 0.3, dampingFraction: 0.6, blendDuration: 0)) {
                    isLoginButtonPressed.toggle()
                }
            }
        }) {
            Text("Log In")
                .font(.headline)
                .foregroundColor(.black)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.white)
                .cornerRadius(10)
                .scaleEffect(isLoginButtonPressed ? 0.95 : 1)
        }
        .padding(.horizontal, 20)
    }
    
    var signUpButton: some View {
        Button(action: {
            withAnimation(.spring(response: 0.3, dampingFraction: 0.6, blendDuration: 0)) {
                isSignUpButtonPressed.toggle()
            }
            
            // Add your sign up navigation logic here
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                withAnimation(.spring(response: 0.3, dampingFraction: 0.6, blendDuration: 0)) {
                    isSignUpButtonPressed.toggle()
                }
            }
        }) {
            Text("New User? Sign Up")
                .font(.headline)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.clear)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.white, lineWidth: 1)
                )
                .cornerRadius(10)
                .scaleEffect(isSignUpButtonPressed ? 0.95 : 1)
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
