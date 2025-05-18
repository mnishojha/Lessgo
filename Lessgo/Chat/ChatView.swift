import SwiftUI

struct ChatsView: View {
    @State private var searchText = ""
    @State private var selectedTab = "message.fill" 
    
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
                                .foregroundColor(.white)
                            
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
                            Text("Your Chats ")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .padding(.horizontal)
                            
                            VStack(spacing: 0) {
                                RecommendedTravelerRow(
                                    image: "first1",
                                    name: "MAX",
                                    country: "INDIA",
                                    flag:""
                                    
                                   
                                )
                                
                                RecommendedTravelerRow(
                                    image: "SECOND2",
                                    name: "MANISH",
                                    country: "Worldwide",
                                    flag:""
                                    
                                )
                                
                                RecommendedTravelerRow(
                                    image: "THIRD",
                                    name: "Engulfedleader2",
                                    country: "USA",
                                    flag:""
                                    
                                )
                                
                                RecommendedTravelerRow(
                                    image: "FOURTH4",
                                    name: "Feegoskye",
                                    country: "KENYA",
                                    flag:""
                                   
                                )
                                
                                RecommendedTravelerRow(
                                    image: "FIFTH5",
                                    name: "SWIFT",
                                    country: "JAPAN",
                                    flag:""
                                   
                                )
                            }
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(16)
                            .padding(.horizontal)
                        }
                    }
                    
                    Spacer()
                    
                    // Custom Tab Bar
                    HStack {
                        TabBarButton(imageName: "house", isSelected: selectedTab == "house")
                        TabBarButton(imageName: "globe", isSelected: selectedTab == "globe")
                        AddButton()
                        TabBarButton(imageName: "mappin", isSelected: selectedTab == "mappin")
                        TabBarButton(imageName: "message.fill", isSelected: selectedTab == "message.fill")
                    }
                    .padding()
                    .background(Color.gray.opacity(0.1))
                }
            }
        }
    }
}

struct TabBarButton: View {
    let imageName: String
    var isSelected: Bool = false
    
    var body: some View {
        Button(action: {}) {
            Image(systemName: imageName)
                .font(.system(size: 20))
                .foregroundColor(isSelected ? .blue : .gray)
                .frame(maxWidth: .infinity)
        }
    }
}

struct AddButton: View {
    var body: some View {
        Button(action: {}) {
            Image(systemName: "plus")
                .font(.system(size: 20))
                .foregroundColor(.white)
                .frame(width: 50, height: 50)
                .background(Color.blue)
                .clipShape(Circle())
                .shadow(radius: 4)
        }
    }
}




struct ChatsView_Previews: PreviewProvider {
    static var previews: some View {
        ChatsView()
            .preferredColorScheme(.dark)
    }
}
