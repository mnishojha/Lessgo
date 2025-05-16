import  SwiftUI

struct TravelHomeView: View {
    @State private var searchText = ""
    @State private var navigateToProfile = false
    
    // Sample data for trending plans
    let trendingPlans = [
        TrendingPlan(title: "Boys trip", image: "miami", country: "USA", participants: ["Max", "Luffy", "Zoro"]),
        TrendingPlan(title: "Florida trippp!!!", image: "florida", country: "USA", participants: ["Nami", "Sanji", "Usopp"])
    ]
    
    var filteredPlans: [TrendingPlan] {
        if searchText.isEmpty {
            return trendingPlans
        } else {
            return trendingPlans.filter { $0.title.localizedCaseInsensitiveContains(searchText) }
        }
    }

    var body: some View {
        NavigationView {
            ZStack {
                Color.black.edgesIgnoringSafeArea(.all)
                
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 24) {
                        // Header
                        HStack {
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Hello")
                                    .font(.title3)
                                    .foregroundColor(.gray)
                                Text("MAX's")
                                    .font(.title)
                                    .fontWeight(.bold)
                            }
                            Spacer()
                            
                            NavigationLink(destination: ProfileView(), isActive: $navigateToProfile) {
                                Image("Profile")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 50, height: 50)
                                    .clipShape(Circle())
                            }
                        }
                        .padding(.horizontal)
                        
                        // Search Bar
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.gray)
                            TextField("Search Trips", text: $searchText)
                                .foregroundColor(.white)
                                .textFieldStyle(PlainTextFieldStyle())
                            
                            Image("profile")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 30, height: 30)
                                .clipShape(Circle())
                            
                            Image("luffy")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 30, height: 30)
                                .clipShape(Circle())
                        }
                        .padding()
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(12)
                        .padding(.horizontal)
                        
                        // Trending Plans
                        VStack(alignment: .leading, spacing: 16) {
                            HStack {
                                Text("Explore")
                                    .font(.title2)
                                    .fontWeight(.bold)
                                Spacer()
                                Button(action: {}) {
                                    HStack {
                                        Text("See more")
                                            .foregroundColor(.blue)
                                        Image(systemName: "chevron.right")
                                            .foregroundColor(.blue)
                                    }
                                }
                            }
                            
                            destinationList
                        }
                        .padding(.horizontal)
                        
                        // Plans you joined
                        VStack(alignment: .leading, spacing: 16) {
                            HStack {
                                Text("Your Plans")
                                    .font(.title2)
                                    .fontWeight(.bold)
                                Spacer()
                                Button(action: {}) {
                                    HStack {
                                        Text("See all")
                                            .foregroundColor(.blue)
                                        Image(systemName: "chevron.right")
                                            .foregroundColor(.blue)
                                    }
                                }
                            }
                            
                            NoPlansView()
                        }
                        .padding(.horizontal)

                        // Discover note
                        VStack(alignment: .leading, spacing: 16) {
                            Text("House Parties/Fest")
                                .font(.title2)
                                .fontWeight(.bold)

                            Text("We're still working on this feature! If you have any suggestions or ideas for new features, please let us know.......")
                                .foregroundColor(.gray)
                                .padding()
                                .background(Color.blue.opacity(0.1))
                                .cornerRadius(12)
                        }
                        .padding(.horizontal)
                    }
                    .padding(.bottom, 80)
                }
            }
            .foregroundColor(.white)
        }
    }
    
    private var destinationList: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 15) {
                ForEach(filteredPlans) { plan in
                    NavigationLink(destination: TripsDetailView()) {
                        destinationCard(imageName: plan.image, cityName: plan.title)
                    }
                }
            }
        }
    }
    
    private func destinationCard(imageName: String, cityName: String) -> some View {
        ZStack(alignment: .bottomLeading) {
            Image(imageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 250, height: 150)
                .clipped()
                .cornerRadius(15)
            
            Text(cityName)
                .font(.title2).bold()
                .foregroundColor(.white)
                .padding()
                .background(LinearGradient(
                    gradient: Gradient(colors: [.black.opacity(0.7), .clear]),
                    startPoint: .bottom, endPoint: .top))
                .cornerRadius(15)
        }
    }
}

// MARK: - Supporting Views and Models

struct TrendingPlan: Identifiable {
    let id = UUID()
    let title: String
    let image: String
    let country: String
    let participants: [String]
}

struct NoPlansView: View {
    var body: some View {
        HStack(spacing: 16) {
            Image("globe_mascot")
                .resizable()
                .frame(width: 60, height: 60)
            
            VStack(alignment: .leading, spacing: 4) {
                Text("No Plans Yet")
                    .font(.title3)
                    .fontWeight(.semibold)
                Text("You haven't joined any plans")
                    .foregroundColor(.gray)
            }
            Spacer()
        }
        .padding()
        .background(Color.blue.opacity(0.1))
        .cornerRadius(16)
    }
}

struct ProfilesView: View {
    var body: some View {
        Text("Profile View")
            .foregroundColor(.white)
            .background(Color.black.edgesIgnoringSafeArea(.all))
    }
}

struct GroupsChatView: View {
    let chatParticipants: [String]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Group Chat")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.white)
            
            Text("Participants:")
                .font(.headline)
                .foregroundColor(.gray)
            
            ForEach(chatParticipants, id: \.self) { name in
                Text("• \(name)")
                    .foregroundColor(.white)
            }
            
            Spacer()
        }
        .padding()
        .background(Color.black.edgesIgnoringSafeArea(.all))
    }
}
struct TravelHomeView_Previews: PreviewProvider {
    static var previews: some View {
        TravelHomeView()
            .preferredColorScheme(.dark)
    }
}
