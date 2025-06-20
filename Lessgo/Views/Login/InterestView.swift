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
        VStack(alignment: .leading, spacing: 20) {
            Text("Select up to 5 interests")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .padding(.horizontal)
                .padding(.top)
                .accessibilityAddTraits(.isHeader)
            
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 110), spacing: 12)], spacing: 12) {
                    ForEach(interests, id: \.self) { interest in
                        InterestButton(title: interest, isSelected: selectedInterests.contains(interest)) {
                            toggleSelection(for: interest)
                        }
                    }
                }
                .padding(.horizontal)
            }

            Spacer()
            
            Button(action: {
                viewModel.selectedInterests = Array(selectedInterests) // ✅ Sync selected items to ViewModel
                onNext()
            }) {
                HStack {
                    Image(systemName: "arrow.right.circle.fill")
                        .font(.title2)
                    Text("Next Step")
                        .font(.headline)
                        .fontWeight(.bold)
                }
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: .infinity)
                .background(selectedInterests.isEmpty ? Color.gray.opacity(0.5) : Color.blue)
                .clipShape(Capsule())
                .shadow(radius: 5)
                .padding(.horizontal)
            }
            .disabled(selectedInterests.isEmpty)
            .padding(.bottom)
        }
        .background(Color.black.edgesIgnoringSafeArea(.all))
        .animation(.easeInOut, value: selectedInterests)
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
                .padding(.vertical, 10)
                .padding(.horizontal, 12)
                .frame(maxWidth: .infinity)
                .background(isSelected ? Color.blue : Color.gray.opacity(0.2))
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(isSelected ? Color.blue : Color.clear, lineWidth: 1)
                )
                .animation(.easeInOut(duration: 0.2), value: isSelected)
        }
        .accessibilityLabel("\(title), \(isSelected ? "selected" : "not selected")")
    }
}

struct InterestView_Previews: PreviewProvider {
    static var previews: some View {
        InterestView(viewModel: ContentViewModel()) {}
            .preferredColorScheme(.dark)
    }
}
