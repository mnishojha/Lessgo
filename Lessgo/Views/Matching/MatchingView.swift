import SwiftUI

struct MatchingView: View {
    // Profile data
    let name = "Max, 20"
    let location = "India"
    let about = "Hii, I'm a traveler :)"
    let interests = ["Mountain", "Hiking", "Beach", "Nature"]
    
    // List of profile images
    let images = ["Profile", "Profile2", "oldman"] // Add image names here

    // State variables
    @State private var offset = CGSize.zero
    @State private var isMatched = false
    @State private var currentImageIndex = 0
    @State private var isZoomed = false  // State to manage zoom view
    @State private var likeStatus: String? = nil  // "Like" or "Dislike" status

    var body: some View {
        ZStack {
            // Background color
            Color.black.edgesIgnoringSafeArea(.all)

            // Profile Card
            VStack {
                if currentImageIndex < images.count {
                    Image(images[currentImageIndex])
                        .resizable()
                        .scaledToFill()
                        .frame(width: 200, height: 200)
                        .clipShape(Circle())
                        .shadow(radius: 10)
                        .onTapGesture {
                            isZoomed = true // Show zoomed view on tap
                        }
                }

                Text(name)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                
                Text(location)
                    .foregroundColor(.gray)
                
                Text(about)
                    .padding()
                    .foregroundColor(.white)
                
                // Interests
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

                if let status = likeStatus {
                    Text(status)
                        .font(.title)
                        .foregroundColor(status == "Liked" ? .green : .red)
                        .transition(.scale)
                }
            }
            .padding()
            .background(Color.gray.opacity(0.2))
            .cornerRadius(20)
            .shadow(radius: 10)
            .offset(x: offset.width, y: offset.height)
            .rotationEffect(.degrees(Double(offset.width / 20)))
            .gesture(
                DragGesture()
                    .onChanged { gesture in
                        offset = gesture.translation
                    }
                    .onEnded { _ in
                        handleSwipe()
                    }
            )
            .sheet(isPresented: $isZoomed) {
                ZoomedImageView(imageName: images[currentImageIndex])
            }
        }
    }
    
    // Function to handle different swipe directions
    private func handleSwipe() {
        withAnimation {
            if offset.width > 100 {
                // Right swipe action (Yes)
                isMatched = true
                offset = CGSize(width: 500, height: 0)
            } else if offset.width < -100 {
                // Left swipe action (No)
                offset = CGSize(width: -500, height: 0)
            } else if offset.height < -100 {
                // Up swipe action (Like)
                likeStatus = "Liked"
                offset = CGSize(width: 0, height: -500)
            } else if offset.height > 100 {
                // Down swipe action (Dislike)
                likeStatus = "Disliked"
                offset = CGSize(width: 0, height: 500)
            } else {
                // Reset if swipe is too weak
                offset = .zero
                likeStatus = nil
            }
            // Move to the next image after swipe
            if offset != .zero {
                nextImage()
            }
        }
    }
    
    // Function to move to the next image or reset
    private func nextImage() {
        offset = .zero
        isMatched = false
        likeStatus = nil
        currentImageIndex = (currentImageIndex + 1) % images.count
    }
}

// View to display the zoomed image
struct ZoomedImageView: View {
    let imageName: String

    var body: some View {
        VStack {
            Image(imageName)
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.black.edgesIgnoringSafeArea(.all))
                .onTapGesture {
                    UIApplication.shared.windows.first?.rootViewController?.dismiss(animated: true)
                }
        }
    }
}

struct MatchingView_Previews: PreviewProvider {
    static var previews: some View {
        MatchingView()
            .preferredColorScheme(.dark)
    }
}
