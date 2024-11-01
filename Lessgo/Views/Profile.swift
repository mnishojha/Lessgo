import SwiftUI

struct ProfileView: View {
    @State private var userName = "John"
    @State private var photos: [String] = [
        "Girl", "oldman", "fight", "trip" // Ensure these match your asset names
    ]
    
    var body: some View {
        VStack {
            // User Greeting
            HStack {
                Text("Welcome, \(userName)")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top, 20)
                    .padding(.leading, 20)
                Spacer()
            }
            
            // Image Carousel
            TabView {
                ForEach(photos, id: \.self) { photo in
                    Image(photo)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: UIScreen.main.bounds.width - 40, height: 400)
                        .cornerRadius(10)
                        .clipped()
                        .padding(.horizontal, 20)
                        .shadow(radius: 5)
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
            .frame(height: 400)
            .padding(.top, 10)
            
            Spacer()
        }
        .padding(.bottom, 20) // Adds spacing at the bottom for safe areas
    }
    
}


struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
            .preferredColorScheme(.dark)
    }
}
