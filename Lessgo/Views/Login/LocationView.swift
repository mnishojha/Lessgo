import SwiftUI

struct LocationPermissionView: View {
    var body: some View {
        NavigationView {
            VStack(alignment: .center, spacing: 20) {
                Spacer()
                
                // Location icon (placeholder, replace with an actual icon if available)
                Image(systemName: "map.fill") // System image for representation
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100)
                    .foregroundColor(.white)
                
                // Title
                Text("Turn on Location Services")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                
                // Subtitle
                Text("To view nearby travelers and find travel plans, your location is needed. You can disable this at any time.")
                    .font(.body)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 30)
                
                Spacer()
                
                // Continue button
                Button(action: {
                    // Action for the "Continue to lessgo" button
                }) {
                    HStack {
                        Text("Continue to Lessgo")
                        Image(systemName: "arrow.right")
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }
                .padding(.horizontal, 20)
            }
            .padding()
            .background(Color.black.edgesIgnoringSafeArea(.all))
            .navigationBarBackButtonHidden(true)
        }
    }
}

struct LocationPermissionView_Previews: PreviewProvider {
    static var previews: some View {
        LocationPermissionView()
            .preferredColorScheme(.dark) // Preview in dark mode
    }
}
