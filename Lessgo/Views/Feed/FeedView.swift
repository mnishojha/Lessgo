import SwiftUI

struct FeedView: View {
    @State private var searchText = ""
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(.systemBackground)
                    .edgesIgnoringSafeArea(.all)
                
                ScrollView {
                    VStack(spacing: 20) {
                        // Search Bar
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.gray)
                            TextField("Search Trips", text: $searchText)
                        }
                        .padding()
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(10)
                        .padding(.horizontal)
                        
                        // Popular Destinations
                        VStack(alignment: .leading) {
                            HStack {
                                Text("Popular Destinations")
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
                            .padding(.horizontal)
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 15) {
                                    DestinationCard(
                                        imageName: "miami",
                                        cityName: "Miami"
                                    )
                                    
                                    DestinationCard(
                                        imageName: "florida",
                                        cityName: "Florida"
                                    )
                                }
                                .padding(.horizontal)
                            }
                        }
                        
                        // Road Trip Post
                        VStack(alignment: .leading, spacing: 12) {
                            // User Info
                            HStack {
                                Image("Profile")
                                    .resizable()
                                    .frame(width: 40, height: 40)
                                    .clipShape(Circle())
                                
                                VStack(alignment: .leading) {
                                    Text("MAX")
                                        .fontWeight(.semibold)
                                    HStack {
                                        
                                        Text("Road Trip")
                                            .foregroundColor(.gray)
                                    }
                                }
                                
                                Spacer()
                                
                                Text("4 days")
                                    .foregroundColor(.gray)
                            }
                            
                            // Trip Title
                            Text("Road trip ")
                                .font(.title3)
                                .fontWeight(.bold)
                            
                            // Trip Description
                            Text("Hi! I am planning to do the road trip to south-eastern Europe and the Balkans, focusing on exploring the capital cities of those countries....")
                                .foregroundColor(.secondary)
                                .lineLimit(6)
                        }
                        .padding()
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(15)
                        .padding(.horizontal)
                    }
                }
                
                // Bottom Navigation
                VStack {
                    Spacer()
                    HStack {
                        TabBarButton(imageName: "house.fill")
                        TabBarButton(imageName: "globe", isSelected: true)
                        AddButton()
                        TabBarButton(imageName: "mappin")
                        TabBarButton(imageName: "message")
                    }
                    .padding()
                    .background(Color(.systemBackground))
                    .shadow(radius: 2)
                }
            }
            .navigationTitle("Feed")
            .navigationBarItems(trailing: Button(action: {}) {
                Image(systemName: "pencil")
                    .foregroundColor(.primary)
            })
        }
    }
}

struct DestinationCard: View {
    let imageName: String
    let cityName: String
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Image(imageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 250, height: 150)
                .clipped()
                .cornerRadius(15)
            
            Text(cityName)
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(
                    LinearGradient(
                        gradient: Gradient(colors: [.black.opacity(0.7), .clear]),
                        startPoint: .bottom,
                        endPoint: .top
                    )
                )
                .cornerRadius(15)
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

struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        FeedView()
            .preferredColorScheme(.dark)
    }
}
