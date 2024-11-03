import SwiftUI

struct TravelHomeView: View {
    @State private var searchText = ""
    
    // Sample data for trending plans
    let trendingPlans = [
        ("Boys trip", "Miami", "USA", 50),
        ("Florida trippp!!!", "Arizona", "Greece", 50)
    ]
    
    var filteredPlans: [(String, String, String, Int)] {
        if searchText.isEmpty {
            return trendingPlans
        } else {
            return trendingPlans.filter { $0.0.localizedCaseInsensitiveContains(searchText) }
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
                            Image("Profile")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 50, height: 50)
                                .clipShape(Circle())
                        }
                        .padding(.horizontal)
                        
                        // Search Bar
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.gray)
                            TextField("Search Trips", text: $searchText)
                                .foregroundColor(.white)
                                .textFieldStyle(PlainTextFieldStyle())
                        }
                        .padding()
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(12)
                        .padding(.horizontal)
                        
                        // Trending Plans
                        VStack(alignment: .leading, spacing: 16) {
                            HStack {
                                Text("Trending Plans")
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
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 16) {
                                    ForEach(filteredPlans, id: \.0) { plan in
                                        TrendingPlanCard(
                                            image: plan.1,
                                            title: plan.0,
                                            country: plan.2,
                                            participants: plan.3
                                        )
                                    }
                                }
                            }
                        }
                        .padding(.horizontal)
                        
                        // Plans you joined
                        VStack(alignment: .leading, spacing: 16) {
                            HStack {
                                Text("Plans you joined")
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
                        
                        // Discover countries
                        VStack(alignment: .leading, spacing: 16) {
                            HStack {
                                Text("Discover countries")
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
                            
                            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                                CountryCard(image: "miami")
                                CountryCard(image: "florida")
                            }
                        }
                        .padding(.horizontal)
                    }
                    .padding(.bottom, 80)
                }
                
                // Bottom Navigation with Safe Area Inset
//                VStack {
//                    Spacer()
//                    BottomNavigationBar()
//                        .background(Color.gray.opacity(0.1))
//                        .safeAreaInset(edge: .bottom) { Color.clear.frame(height: 0) }
//                }
            }
            .foregroundColor(.white)
        }
    }
}

struct TrendingPlanCard: View {
    let image: String
    let title: String
    let country: String
    let participants: Int
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Image(image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 280, height: 180)
                .clipped()
                .cornerRadius(16)
            
            Text(title)
                .font(.title3)
                .fontWeight(.bold)
            
            HStack {
                Text(country)
                    .foregroundColor(.gray)
                Spacer()
                Image(systemName: "person.fill")
                    .foregroundColor(.gray)
                Text("\(participants)")
                    .foregroundColor(.gray)
            }
        }
        .frame(width: 280)
    }
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

struct CountryCard: View {
    let image: String
    
    var body: some View {
        Image(image)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(height: 150)
            .clipped()
            .cornerRadius(16)
    }
}

//struct BottomNavigationBar: View {
//    var body: some View {
//        HStack {
//            TabButton(imageName: "house.fill", isSelected: true)
//            TabButton(imageName: "globe")
//            AddButton()
//            TabButton(imageName: "mappin")
//            TabButton(imageName: "message")
//        }
//        .padding(.vertical, 8)
//        .padding(.horizontal)
//        .background(Color.gray.opacity(0.1))
//        .overlay(
//            Rectangle()
//                .frame(height: 1)
//                .foregroundColor(.gray.opacity(0.2)),
//            alignment: .top
//        )
//    }
//}

struct TabButton: View {
    let imageName: String
    var isSelected: Bool = false
    var action: () -> Void = {}
    
    var body: some View {
        Button(action: action) {
            Image(systemName: imageName)
                .font(.system(size: 22))
                .foregroundColor(isSelected ? .blue : .gray)
                .frame(maxWidth: .infinity)
        }
    }
}

struct TravelHomeView_Previews: PreviewProvider {
    static var previews: some View {
        TravelHomeView()
            .preferredColorScheme(.dark)
    }
}
