import SwiftUI

class TripPlanningViewModel: ObservableObject {
    @Published var destination: String = ""
    @Published var arrivalDate: Date = Date()
    @Published var departureDate: Date = Date()
}

struct TripPlanningView: View {
    @ObservedObject var viewModel: TripPlanningViewModel
    var onNext: () -> Void
    
    private let destinationsByRegion: [String: [String]] = [
        "North India": ["Delhi", "Agra", "Jaipur", "Varanasi", "Amritsar", "Shimla", "Manali", "Rishikesh"],
        "South India": ["Bangalore", "Chennai", "Hyderabad", "Kochi", "Mysore", "Ooty", "Munnar", "Hampi"],
        "West India": ["Mumbai", "Goa", "Udaipur", "Jodhpur", "Ahmedabad", "Mount Abu", "Pune"],
        "East India": ["Kolkata", "Darjeeling", "Gangtok", "Puri", "Shillong", "Kaziranga"],
        "International": ["Paris", "London", "Tokyo", "New York", "Dubai", "Singapore"]
    ]
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 24) {
                Text("Do you have an upcoming trip?")
                    .font(.system(size: 32, weight: .bold))
                    .foregroundColor(.white)
                    .padding(.top, 16)
                
                DestinationPickerView(selectedDestination: $viewModel.destination, destinations: destinationsByRegion)
                DatePickerView(title: "Arrival Date", date: $viewModel.arrivalDate)
                DatePickerView(title: "Departure Date", date: $viewModel.departureDate)
                
                Spacer()
                
                Button(action: {
                    onNext()
                }) {
                    HStack {
                        Text("Continue")
                            .fontWeight(.semibold)
                        Image(systemName: "arrow.right")
                    }
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 25)
                            .fill(Color.blue)
                    )
                }
            }
            .padding()
            .background(Color.black.edgesIgnoringSafeArea(.all))
        }
    }
}

// Custom Destination Picker View
struct DestinationPickerView: View {
    @Binding var selectedDestination: String
    let destinations: [String: [String]]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Destination")
                .font(.headline)
                .foregroundColor(.white)
            
            Menu {
                ForEach(destinations.keys.sorted(), id: \.self) { region in
                    Menu(region) {
                        ForEach(destinations[region] ?? [], id: \.self) { destination in
                            Button(destination) {
                                selectedDestination = destination
                            }
                        }
                    }
                }
            } label: {
                HStack {
                    Text(selectedDestination.isEmpty ? "Select destination" : selectedDestination)
                        .foregroundColor(selectedDestination.isEmpty ? .gray : .white)
                    Spacer()
                    Image(systemName: "chevron.down")
                        .foregroundColor(.gray)
                }
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
            }
        }
    }
}

// Custom Date Picker View
struct DatePickerView: View {
    let title: String
    @Binding var date: Date
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.headline)
                .foregroundColor(.white)
            
            DatePicker("", selection: $date, displayedComponents: .date)
                .labelsHidden()
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
        }
    }
}

// Preview
struct TripPlanningView_Previews: PreviewProvider {
    static var previews: some View {
        TripPlanningView(viewModel: TripPlanningViewModel()) {
            // onNext Preview
        }
        .preferredColorScheme(.dark)
    }
}
