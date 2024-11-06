import SwiftUI

struct InterestView: View {
    @State private var selectedInterests: Set<String> = []
    private let interests = [
        "Adventure", "Au Pair", "Backpacking", "Beach",
        "Budget Travel", "Camping", "Cruise", "Digital Nomad",
        "Diving", "Hiking", "Hostel", "Interrail",
        "Living Abroad", "Luxury Travel", "Nature", "Night Life",
        "Road Trip", "Skiing"
    ]

    var body: some View {
        NavigationView {
            VStack {
                Text("Select up to 5 interests")
                    .font(.title)
                    .bold()
                    .foregroundColor(.white)
               
                
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 120), spacing: 15)], spacing: 15) {
                    ForEach(interests, id: \.self) { interest in
                        InterestButton(title: interest, isSelected: selectedInterests.contains(interest)) {
                            toggleSelection(for: interest)
                        }
                    }
                }
                .padding()

                Button(action: {
                    // Action when the Continue button is pressed
                }) {
                    Text("Continue")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()
                .disabled(selectedInterests.count == 0) // Disable if no interest selected
            }
            .padding()
            .background(Color.black.edgesIgnoringSafeArea(.all))
            .navigationBarBackButtonHidden(true)
        }
    }

    private func toggleSelection(for interest: String) {
        if selectedInterests.contains(interest) {
            selectedInterests.remove(interest)
        } else if selectedInterests.count < 5 {
            selectedInterests.insert(interest)
        }
    }
}



struct InterestView_Previews: PreviewProvider {
    static var previews: some View {
        InterestView()
            .preferredColorScheme(.dark)
    }
}
