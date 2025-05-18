import SwiftUI

struct ChatView: View {
    @State private var searchText = ""
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.black.edgesIgnoringSafeArea(.all)
                
                VStack(spacing: 0) {
                    // Header
                    HStack {
                        Text("Chats")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        Spacer()
                        Button(action: {}) {
                            Text("Requests (0)")
                                .foregroundColor(.blue)
                                .padding(.horizontal, 12)
                                .padding(.vertical, 6)
                                .background(Color.blue.opacity(0.1))
                                .cornerRadius(16)
                        }
                    }
                    .padding()
                    
                    // Search Bar
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                        TextField("Search", text: $searchText)
                            .foregroundColor(.white)
                    }
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(10)
                    .padding(.horizontal)
                    
                    ScrollView {
                        // No Messages State
                        VStack(spacing: 12) {
                            Image("globe_mascot") // Replace with your mascot image
                                .resizable()
                                .frame(width: 60, height: 60)
                            
                            Text("No Messages Yet")
                                .font(.title2)
                                .fontWeight(.semibold)
                            
                            Text("You haven't messaged anyone!")
                                .foregroundColor(.gray)
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(16)
                        .padding()
                        
                        // Recommended Travelers
                        VStack(alignment: .leading, spacing: 20) {
                            Text("Recommended Travelers")
                                .font(.title2)
                                .fontWeight(.bold)
                                .padding(.horizontal)
                            
                            VStack(spacing: 0) {
                                RecommendedTravelerRow(
                                    image: "traveler1",
                                    name: "Jehan",
                                    country: "Philippines",
                                    flag: "🇵🇭"
                                )
                                
                                RecommendedTravelerRow(
                                    image: "traveler2",
                                    name: "Sineen",
                                    country: "Worldwide",
                                    flag: "🌎"
                                )
                                
                                RecommendedTravelerRow(
                                    image: "traveler3",
                                    name: "Sama",
                                    country: "Egypt",
                                    flag: "🇪🇬"
                                )
                                
                                RecommendedTravelerRow(
                                    image: "traveler4",
                                    name: "Emely",
                                    country: "Austria",
                                    flag: "🇦🇹"
                                )
                                
                                RecommendedTravelerRow(
                                    image: "traveler5",
                                    name: "Brie",
                                    country: "France",
                                    flag: "🇫🇷"
                                )
                            }
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(16)
                            .padding(.horizontal)
                        }
                    }
                    
                    Spacer()
                    
                    // Bottom Navigation
                    HStack {
                        TabBarButton(imageName: "house", isSelected: false)
                        TabBarButton(imageName: "globe", isSelected: false)
                        AddButton()
                        TabBarButton(imageName: "mappin", isSelected: false)
                        TabBarButton(imageName: "message.fill", isSelected: true)
                    }
                    .padding()
                    .background(Color.gray.opacity(0.1))
                }
            }
            .foregroundColor(.white)
        }
    }
}

struct RecommendedTravelerRow: View {
    let image: String
    let name: String
    let country: String
    let flag: String
    
    var body: some View {
        Button(action: {}) {
            HStack {
                Image(image)
                    .resizable()
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(name)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                    
                    HStack {
                        Text(country)
                            .foregroundColor(.gray)
                        Text(flag)
                    }
                }
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .foregroundColor(.gray)
            }
            .padding()
        }
        .background(Color.clear)
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatsView()
            .preferredColorScheme(.dark)
    }
}
