import SwiftUI

struct MatchingView: View {
    // Profile data
    let name = "Max, 20"
    let location = "India"
    let about = "Hii, I'm a traveler :)"
    let interests = ["Mountain", "Hiking", "Beach", "Nature"]

    // Gesture state
    @State private var offset = CGSize.zero
    @State private var isMatched = false

    var body: some View {
        ZStack {
            // Background color for dark theme
            Color.black.edgesIgnoringSafeArea(.all)

            // Profile Card
            VStack {
                Image("Profile") // Replace with actual image or URL
                    .resizable()
                    .scaledToFill()
                    .frame(width: 200, height: 200)
                    .clipShape(Circle())
                    .shadow(radius: 10)
                
                Text(name)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                
                Text(location)
                    .foregroundColor(.gray)
                
                Text(about)
                    .padding()
                    .foregroundColor(.white)
                
                // Displaying Interests
                HStack {
                    ForEach(interests, id: \.self) { interest in
                        Text(interest)
                            .padding(8)
                            .background(Color.gray.opacity(0.2))
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
                .padding(.bottom, 20)
                
                if isMatched {
                    Text("It's a Match!")
                        .font(.title)
                        .foregroundColor(.green)
                        .transition(.scale)
                }
            }
            .padding()
            .background(Color.gray.opacity(0.2))
            .cornerRadius(20)
            .shadow(radius: 10)
            .offset(x: offset.width, y: 0)
            .rotationEffect(.degrees(Double(offset.width / 20)))
            .gesture(
                DragGesture()
                    .onChanged { gesture in
                        offset = gesture.translation
                    }
                    .onEnded { _ in
                        if offset.width > 100 {
                            // Right swipe action (Yes)
                            withAnimation {
                                isMatched = true
                                offset = CGSize(width: 500, height: 0)
                            }
                        } else if offset.width < -100 {
                            // Left swipe action (No)
                            withAnimation {
                                offset = CGSize(width: -500, height: 0)
                            }
                        } else {
                            // Reset position if swipe is too weak
                            offset = .zero
                        }
                    }
            )
            .onAppear {
                offset = .zero
                isMatched = false
            }
        }
    }
}

struct MatchingView_Previews: PreviewProvider {
    static var previews: some View {
        MatchingView() // Updated to call MatchingView instead of ProfileView
            .preferredColorScheme(.dark) // Dark theme preview
    }
}
