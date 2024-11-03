import SwiftUI

struct TripDetailView: View {
    @State private var showAboutTrip = false

    var body: some View {
        VStack(spacing: 16) {
            // Header Image with Gradient Overlay
            ZStack(alignment: .bottomLeading) {
                Image("miami") // Replace with your image name
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 220)
                    .clipped()
                    .cornerRadius(20)
                    .padding(.horizontal)
                
                LinearGradient(
                    gradient: Gradient(colors: [Color.black.opacity(0.6), Color.clear]),
                    startPoint: .bottom,
                    endPoint: .top
                )
                .frame(height: 100)
                .cornerRadius(20)
                .padding(.horizontal)
                
                Text("Boys Trip")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding([.leading, .bottom], 24)
            }

            // Trip Details Card
            VStack(alignment: .leading, spacing: 16) {
                // Title and Bookmark Icon
                HStack {
                    Text("Boys Trip")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    Spacer()
                    
                    HStack(spacing: 16) {
                        Button(action: {
                            // Bookmark action
                        }) {
                            Image(systemName: "bookmark")
                                .font(.title2)
                                .foregroundColor(.gray)
                        }
                        
                        Button(action: {
                            // Share action
                        }) {
                            Image(systemName: "square.and.arrow.up")
                                .font(.title2)
                                .foregroundColor(.gray)
                        }
                    }
                }
                
                // Date and Travelers Info
                HStack(spacing: 16) {
                    Label("nov 4, 2024 - nov 9, 2024", systemImage: "calendar")
                        .foregroundColor(.gray)
                    
                    Label("12 travelers  >", systemImage: "person.2.fill")
                        .foregroundColor(.gray)
                }
                .font(.subheadline)
                
                // Join Button with Gradient and Shadow
                Button(action: {
                    // Join group action
                }) {
                    Text("Let's Go")
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(
                            LinearGradient(
                                gradient: Gradient(colors: [Color.green, Color.blue]),
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .foregroundColor(.white)
                        .cornerRadius(12)
                        .shadow(color: Color.blue.opacity(0.3), radius: 10, x: 0, y: 5)
                }
                .padding(.top, 8)
                
                // About Trip Section with Rounded Background
                DisclosureGroup(isExpanded: $showAboutTrip) {
                    Text("Hi guys! this is my first project using swift ui , hope you like this app and enjoy it. thanks you")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.black.opacity(0.8))
                        .cornerRadius(10)
                        .padding(.horizontal, 4)
                } label: {
                    Text("About Trip")
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                }
                .padding(.top, 16)
            }
            .padding()
            .background(Color.black.opacity(0.85))
            .cornerRadius(16)
            .padding(.horizontal)
            .shadow(color: Color.black.opacity(0.3), radius: 10, x: 0, y: 5)
            
            Spacer()
        }
        .background(Color.black.edgesIgnoringSafeArea(.all))
    }
}

struct TripDetailView_Previews: PreviewProvider {
    static var previews: some View {
        TripDetailView()
            .preferredColorScheme(.dark)
    }
}
