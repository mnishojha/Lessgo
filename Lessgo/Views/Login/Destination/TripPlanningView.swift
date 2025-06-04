//import SwiftUI
//
//struct TripPlanningView: View {
//    @ObservedObject var viewModel: ContentViewModel
//    @State private var destination: String = ""
//    @State private var arrivalDate: Date = Date()
//    @State private var departureDate: Date = Date()
//    
//    var onNext: () -> Void
//    
//    private let destinationsByRegion: [String: [String]] = [
//        "North India": ["Delhi", "Agra", "Jaipur", "Varanasi", "Amritsar", "Shimla", "Manali", "Rishikesh"],
//        "South India": ["Bangalore", "Chennai", "Hyderabad", "Kochi", "Mysore", "Ooty", "Munnar", "Hampi"],
//        "West India": ["Mumbai", "Goa", "Udaipur", "Jodhpur", "Ahmedabad", "Mount Abu", "Pune"],
//        "East India": ["Kolkata", "Darjeeling", "Gangtok", "Puri", "Shillong", "Kaziranga"],
//        "International": ["Paris", "London", "Tokyo", "New York", "Dubai", "Singapore"]
//    ]
//    
//    // Custom initializer
//    init(viewModel: ContentViewModel, onNext: @escaping () -> Void) {
//        self.viewModel = viewModel
//        self.onNext = onNext
//    }
//    
//    var body: some View {
//        NavigationView {
//            VStack(alignment: .leading, spacing: 24) {
//                // Title
//                Text("Do you have an upcoming trip?")
//                    .font(.system(size: 32, weight: .bold))
//                    .foregroundColor(.white)
//                    .padding(.top, 16)
//                
//                // Destination section using custom picker
//                DestinationPickerView(selectedDestination: $destination, destinations: destinationsByRegion)
//                
//                // Date section with custom date pickers
//                DatePickerView(title: "Arrival Date", date: $arrivalDate)
//                DatePickerView(title: "Departure Date", date: $departureDate)
//                
//                Spacer()
//                
//                // Continue Button with custom style
//                Button(action: {
//                    onNext()
//                }) {
//                    HStack {
//                        Text("Continue")
//                            .fontWeight(.semibold)
//                        Image(systemName: "arrow.right")
//                    }
//                    .foregroundColor(.white)
//                    .frame(maxWidth: .infinity)
//                    .padding()
//                    .background(
//                        RoundedRectangle(cornerRadius: 25)
//                            .fill(Color.blue)
//                    )
//                }
//            }
//            .padding()
//            .background(Color.black.edgesIgnoringSafeArea(.all))
//         
//                // Add your back action here
//        };
//                Image(systemName: "arrow.left")
//                    .foregroundColor(.white)
//            }
//        }
//    
//
//
//// Custom Destination Picker View
//struct DestinationPickerView: View {
//    @Binding var selectedDestination: String
//    let destinations: [String: [String]]
//    
//    var body: some View {
//        VStack(alignment: .leading, spacing: 8) {
//            Text("Destination")
//                .font(.headline)
//                .foregroundColor(.white)
//            
//            Menu {
//                ForEach(destinations.keys.sorted(), id: \.self) { region in
//                    Menu(region) {
//                        ForEach(destinations[region] ?? [], id: \.self) { destination in
//                            Button(destination) {
//                                selectedDestination = destination
//                            }
//                        }
//                    }
//                }
//            } label: {
//                HStack {
//                    Text(selectedDestination.isEmpty ? "Select destination" : selectedDestination)
//                        .foregroundColor(selectedDestination.isEmpty ? .gray : .white)
//                    Spacer()
//                    Image(systemName: "chevron.down")
//                        .foregroundColor(.gray)
//                }
//                .padding()
//                .background(Color.gray.opacity(0.2))
//                .cornerRadius(10)
//            }
//        }
//    }
//}
//
//// Custom Date Picker View
//struct DatePickerView: View {
//    let title: String
//    @Binding var date: Date
//    
//    var body: some View {
//        VStack(alignment: .leading, spacing: 8) {
//            Text(title)
//                .font(.headline)
//                .foregroundColor(.white)
//            
//            DatePicker("", selection: $date, displayedComponents: .date)
//                .labelsHidden()
//                .padding()
//                .background(Color.gray.opacity(0.2))
//                .cornerRadius(10)
//        }
//    }
//}
//
//
//struct TripPlanningView_Previews: PreviewProvider {
//    static var previews: some View {
//        TripPlanningView(viewModel: ContentViewModel()) {
//            // Sample onNext action for preview
//        }
//        .preferredColorScheme(.dark)
//    }
//}
