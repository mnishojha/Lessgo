import SwiftUI

struct StylizedSplashView: View {
    @State private var isActive = false
    @State private var size = 0.8
    @State private var opacity = 0.5
    @State private var rotation = 0.0
    
    var body: some View {
        if isActive {
            LoginView()
        } else {
            ZStack {
                // Solid black background
                Color.black
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    // Logo and title container
                    VStack(spacing: 25) {
                        // App icon with circular shape
                        ZStack {
                            Circle()
                                .fill(Color.black)
                                .frame(width: 120, height: 120)
                                .shadow(color: Color.white.opacity(0.3), radius: 15, x: 0, y: 5)
                            
                            Image(systemName: "mountain.2")
                                .font(.system(size: 60))
                                .foregroundColor(.white)
                                
                        }
                        
                        // App title with pure white color
                        Text("LESSGO")
                            .font(.custom("Helvetica Neue", size: 46))
                            .fontWeight(.heavy)
                            .foregroundColor(.white)
                            .shadow(color: .white.opacity(0.3), radius: 5, x: 0, y: 2)
                        
                        // Tagline
                        Text("Find Your Adventure Companion")
                            .font(.system(size: 18, weight: .medium))
                            .foregroundColor(.white.opacity(0.8))
                            .padding(.top, 4)
                        
                        // Loading indicator
                        LoadingIndicator()
                            .padding(.top, 40)
                    }
                    .scaleEffect(size)
                    .opacity(opacity)
                    .onAppear {
                        // Combined animations
                        withAnimation(.easeInOut(duration: 1.2)) {
                            self.size = 0.9
                            self.opacity = 1.0
                        }
                        
                        withAnimation(.linear(duration: 1.0).repeatForever(autoreverses: false)) {
                            self.rotation = 360.0
                        }
                    }
                }
                .padding()
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                    withAnimation {
                        self.isActive = true
                    }
                }
            }
        }
    }
}


// Preview
struct StylizedSplashView_Previews: PreviewProvider {
    static var previews: some View {
        StylizedSplashView()
    }
}
