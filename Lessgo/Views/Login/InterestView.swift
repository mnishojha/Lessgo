import SwiftUI

struct InterestView: View {
    @ObservedObject var viewModel: ContentViewModel
    @State private var selectedInterests: Set<String> = []
    
    private let interests = [
        "Adventure", "Au Pair", "Backpacking", "Beach",
        "Budget Travel", "Camping", "Cruise", "Digital Nomad",
        "Diving", "Hiking", "Hostel", "Interrail",
        "Living Abroad", "Luxury Travel", "Nature", "Night Life",
        "Road Trip", "Skiing"
    ]
    
    var onNext: () -> Void
    
    var body: some View {
        VStack {
            Text("Select up to 5 interests")
                .font(.title2)
                .bold()
                .foregroundColor(.white)
                .padding(.bottom, 10)
            
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 120), spacing: 15)], spacing: 15) {
                ForEach(interests, id: \.self) { interest in
                    InterestButton(title: interest, isSelected: selectedInterests.contains(interest)) {
                        toggleSelection(for: interest)
                    }
                }
            }
            .padding()
            
            Spacer()
            
            // ✅ New Button
            Button(action: {
                onNext() // ✅ Go to next step without modifying viewModel here
            }) {
                HStack {
                    Image(systemName: "arrow.right.circle.fill")
                        .font(.title3)
                    
                    Text("Next Step")
                        .font(.headline)
                        .bold()
                }
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding()
                .background(selectedInterests.count > 0 ? Color.blue : Color.gray.opacity(0.5))
                .clipShape(Capsule())
                .shadow(radius: 5)
                .padding(.horizontal, 24)
                .animation(.easeInOut, value: selectedInterests.count)
            }
            .disabled(selectedInterests.isEmpty) // ✅ Disable when no interests selected
        }
        .padding()
        .background(Color.black.edgesIgnoringSafeArea(.all))
    }
    
    private func toggleSelection(for interest: String) {
        if selectedInterests.contains(interest) {
            selectedInterests.remove(interest)
        } else if selectedInterests.count < 5 {
            selectedInterests.insert(interest)
        }
    }
}

struct InterestButton: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.subheadline)
                .foregroundColor(isSelected ? .white : .gray)
                .padding()
                .frame(maxWidth: .infinity)
                .background(isSelected ? Color.blue : Color.gray.opacity(0.2))
                .cornerRadius(10)
                .animation(.easeInOut, value: isSelected)
        }
    }
}

struct InterestView_Previews: PreviewProvider {
    static var previews: some View {
        InterestView(viewModel: ContentViewModel()) {
            // Sample onNext action
        }
        .preferredColorScheme(.dark)
    }
}
