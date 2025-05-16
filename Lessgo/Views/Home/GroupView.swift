import SwiftUI

struct TripsDetailView: View {
    @State private var showAboutTrip = false
    @State private var navigateToGroupChat = false
    @State private var chatParticipants = ["Alex", "Sam", "Jordan", "Chris", "Taylor"] // Example participants

    var body: some View {
        NavigationStack {
            ZStack {
                Color.black
                    .ignoresSafeArea()

                ScrollView {
                    VStack(spacing: 16) {
                        // Header Image with Gradient Overlay
                        ZStack(alignment: .bottomLeading) {
                            Image("miami")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(height: 300)
                                .clipped()

                            LinearGradient(
                                gradient: Gradient(colors: [Color.black.opacity(0.6), Color.clear]),
                                startPoint: .bottom,
                                endPoint: .top
                            )
                            .frame(height: 150)

                            Text("Boys Trip")
                                .font(.largeTitle)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .padding([.leading, .bottom], 24)
                        }
                        .frame(maxWidth: .infinity)

                        // Trip Details Card
                        VStack(alignment: .leading, spacing: 16) {
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

                            HStack(spacing: 16) {
                                Label("12 travelers >", systemImage: "person.2.fill")
                                    .foregroundColor(.gray)
                            }
                            .font(.subheadline)

                            Button(action: {
                                navigateToGroupChat = true
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

                            DisclosureGroup(isExpanded: $showAboutTrip) {
                                VStack(alignment: .leading, spacing: 8) {
                                    Label("Nov 4, 2024 - Nov 9, 2024", systemImage: "calendar")
                                        .foregroundColor(.gray)
                                        .font(.caption)
                                    Text("Hi guys! This is my first project using SwiftUI, hope you like this app and enjoy it. Thank you!")
                                        .foregroundColor(.white)
                                        .font(.subheadline)
                                }
                                .padding(.top, 8)
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

                        Spacer(minLength: 30)
                    }
                }
            }
            .navigationBarHidden(true)
            .navigationDestination(isPresented: $navigateToGroupChat) {
                GroupChatView(chatParticipants: chatParticipants) // <-- Pass the participants
            }
        }
    }
}

struct TripsDetailView_Previews: PreviewProvider {
    static var previews: some View {
        TripsDetailView()
    }
}
