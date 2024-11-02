
import SwiftUI

struct MatchingView: View {
    @State private var currentIndex = 0
    @State private var potentialMatches: [Match] = [
        Match(name: "MAX", age: 28, bio: "Adventure seeker and coffee lover", photo: "fight"),
        Match(name: "MANISH", age: 30, bio: "Fitness enthusiast and dog person", photo: "Girl"),
        Match(name: "Engulfedleader2", age: 26, bio: "Bookworm and aspiring chef", photo: "oldman"),
        Match(name: "feegoskye", age: 29, bio: "Tech geek and movie buff", photo: "trip"),
        Match(name: "Unknown", age: 27, bio: "Artist and nature lover", photo: "Profile")
    ]
    
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            
            VStack {
                Text("Find Your Travling Companion")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.top, 20)
                
                TabView(selection: $currentIndex) {
                    ForEach(potentialMatches.indices, id: \.self) { index in
                        VStack {
                            ZStack(alignment: .topLeading) {
                                Image(potentialMatches[index].photo)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: UIScreen.main.bounds.width - 40, height: 400)
                                    .cornerRadius(10)
                                    .clipped()
                                
                                if potentialMatches[index].liked != nil {
                                    Image(systemName: potentialMatches[index].liked ?? false ? "heart.fill" : "xmark")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 80, height: 80)
                                        .foregroundColor(potentialMatches[index].liked ?? false ? .green : .red)
                                        .padding(20)
                                }
                            }
                            
                            Text(potentialMatches[index].name)
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                            
                            Text("\(potentialMatches[index].age) years old")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                            
                            Text(potentialMatches[index].bio)
                                .font(.body)
                                .multilineTextAlignment(.center)
                                .padding(.horizontal)
                                .padding(.top, 5)
                                .foregroundColor(.white)
                        }
                        .tag(index)
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                .frame(height: 550)
                .padding(.horizontal, 20)
                
                HStack(spacing: 50) {
                    Button(action: { swipeLeft() }) {
                        Image(systemName: "xmark.circle.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 60, height: 60)
                            .foregroundColor(.red)
                    }
                    .disabled(potentialMatches[currentIndex].liked != nil)
                    
                    Button(action: { swipeRight() }) {
                        Image(systemName: "heart.circle.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 60, height: 60)
                            .foregroundColor(.green)
                    }
                    .disabled(potentialMatches[currentIndex].liked != nil)
                }
                .padding(.top, 20)
                
                Spacer()
            }
        }
    }
    
    func swipeLeft() {
        potentialMatches[currentIndex].liked = false
        moveToNextMatch()
    }
    
    func swipeRight() {
        potentialMatches[currentIndex].liked = true
        moveToNextMatch()
        // Here you would typically implement match logic
        print("It's a match with \(potentialMatches[currentIndex].name)!")
    }
    
    func moveToNextMatch() {
        withAnimation {
            if currentIndex < potentialMatches.count - 1 {
                currentIndex += 1
            } else {
                // Reset to the first match if we've reached the end
                currentIndex = 0
            }
        }
    }
}

struct Match: Identifiable {
    let id = UUID()
    let name: String
    let age: Int
    let bio: String
    let photo: String
    var liked: Bool?
}

struct MatchingView_Previews: PreviewProvider {
    static var previews: some View {
        MatchingView()
    }
}
