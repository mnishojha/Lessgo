import SwiftUI

struct FeedView: View {
    @State private var searchText = ""
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(.systemBackground).edgesIgnoringSafeArea(.all)
                
                ScrollView {
                    VStack(spacing: 20) {
                        searchBar
                        sectionHeader("Popular Destinations", actionText: "See all")
                        destinationList
                        roadTripPost
                    }
                    .padding(.horizontal)
                }
            }
            .navigationTitle("Feed")
            .navigationBarItems(trailing: addPostButton)
        }
    }
    
    // now ill save component here
    
    private var searchBar: some View {
        HStack {
            Image(systemName: "magnifyingglass").foregroundColor(.gray)
            TextField("Search Trips", text: $searchText)
        }
        .modifier(BackgroundStyle())
    }
    
    private func sectionHeader(_ title: String, actionText: String) -> some View {
        HStack {
            Text(title).font(.title2).bold()
            Spacer()
            Button(action: {}) {
                Label(actionText, systemImage: "chevron.right").foregroundColor(.blue)
            }
        }
    }
    
    private var destinationList: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 15) {
                destinationCard(imageName: "miami", cityName: "Miami")
                destinationCard(imageName: "florida", cityName: "Florida")
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
    
    // From here the tweet view is start , the person can give feedback and ask question (anything)
    
    private var roadTripPost: some View {
        VStack(alignment: .leading, spacing: 12) {
            postHeader
            Text("Road trip").font(.title3).bold()
            Text("Hi! I am planning to do the road trip to south-eastern Europe and the Balkans, focusing on exploring the capital cities of those countries....")
                .foregroundColor(.secondary)
                .lineLimit(6)
        }
        .modifier(BackgroundStyle())
    }
    
    private var postHeader: some View {
        HStack {
            Image("Profile").resizable().frame(width: 40, height: 40).clipShape(Circle())
            VStack(alignment: .leading) {
                Text("MAX").bold()
                Text("Road Trip").foregroundColor(.gray)
            }
            Spacer()
            Text("4 days").foregroundColor(.gray)
        }
    }
    
    private var addPostButton: some View {
        Button(action: {}) {
            Image(systemName: "pencil").foregroundColor(.primary)
        }
    }
}

// it will modify the search and the feedback background style and color 

private struct BackgroundStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .background(Color.gray.opacity(0.1))
            .cornerRadius(10)
    }
}

struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        FeedView().preferredColorScheme(.dark)
    }
}
