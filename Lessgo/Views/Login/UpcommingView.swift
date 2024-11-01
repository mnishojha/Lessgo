import SwiftUI

struct Destination: Identifiable {
    let id = UUID()
    let name: String
    let region: String
}

struct TripPlanningView: View {
    @State private var destination: String = ""
    @State private var arrivalDate: Date = Date()
    @State private var departureDate: Date = Date()
    @Environment(\.colorScheme) var colorScheme
    
    // Grouped destinations by region
    let destinations: [String: [Destination]] = [
        "North India": [
            Destination(name: "Delhi", region: "North India"),
            Destination(name: "Agra", region: "North India"),
            Destination(name: "Jaipur", region: "North India"),
            Destination(name: "Varanasi", region: "North India"),
            Destination(name: "Amritsar", region: "North India"),
            Destination(name: "Shimla", region: "North India"),
            Destination(name: "Manali", region: "North India"),
            Destination(name: "Rishikesh", region: "North India")
        ],
        "South India": [
            Destination(name: "Bangalore", region: "South India"),
            Destination(name: "Chennai", region: "South India"),
            Destination(name: "Hyderabad", region: "South India"),
            Destination(name: "Kochi", region: "South India"),
            Destination(name: "Mysore", region: "South India"),
            Destination(name: "Ooty", region: "South India"),
            Destination(name: "Munnar", region: "South India"),
            Destination(name: "Hampi", region: "South India")
        ],
        "West India": [
            Destination(name: "Mumbai", region: "West India"),
            Destination(name: "Goa", region: "West India"),
            Destination(name: "Udaipur", region: "West India"),
            Destination(name: "Jodhpur", region: "West India"),
            Destination(name: "Ahmedabad", region: "West India"),
            Destination(name: "Mount Abu", region: "West India"),
            Destination(name: "Pune", region: "West India")
        ],
        "East India": [
            Destination(name: "Kolkata", region: "East India"),
            Destination(name: "Darjeeling", region: "East India"),
            Destination(name: "Gangtok", region: "East India"),
            Destination(name: "Puri", region: "East India"),
            Destination(name: "Shillong", region: "East India"),
            Destination(name: "Kaziranga", region: "East India")
        ],
        "International": [
            Destination(name: "Paris", region: "International"),
            Destination(name: "London", region: "International"),
            Destination(name: "Tokyo", region: "International"),
            Destination(name: "New York", region: "International"),
            Destination(name: "Dubai", region: "International"),
            Destination(name: "Singapore", region: "International")
        ]
    ]
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 24) {
                // Progress bar
                HStack(spacing: 4) {
                    ForEach(0..<10, id: \.self) { index in
                        Rectangle()
                            .frame(height: 4)
                            .foregroundColor(index < 8 ? .blue : .gray.opacity(0.3))
                    }
                }
                .padding(.top, 8)
                
                // Title
                Text("Do you have an upcoming trip?")
                    .font(.system(size: 32, weight: .bold))
                    .padding(.top, 16)
                
                // Destination section
                VStack(alignment: .leading, spacing: 8) {
                    Text("Destination")
                        .font(.headline)
                    
                    Menu {
                        ForEach(Array(destinations.keys.sorted()), id: \.self) { region in
                            Menu(region) {
                                ForEach(destinations[region] ?? [], id: \.id) { dest in
                                    Button(dest.name) {
                                        destination = dest.name
                                    }
                                }
                            }
                        }
                    } label: {
                        HStack {
                            Text(destination.isEmpty ? "Select destination" : destination)
                                .foregroundColor(destination.isEmpty ? .gray : .primary)
                            Spacer()
                            Image(systemName: "chevron.down")
                                .foregroundColor(.gray)
                        }
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 15)
                                .fill(colorScheme == .dark ? Color(white: 0.2) : .white)
                                .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
                        )
                    }
                }
                
                // Date section
                VStack(alignment: .leading, spacing: 8) {
                    Text("Date")
                        .font(.headline)
                    
                    // Arrival Date
                    DatePicker(
                        "Arrival Date",
                        selection: $arrivalDate,
                        displayedComponents: .date
                    )
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 15)
                            .fill(colorScheme == .dark ? Color(white: 0.2) : .white)
                            .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
                    )
                    
                    // Departure Date
                    DatePicker(
                        "Departing Date",
                        selection: $departureDate,
                        displayedComponents: .date
                    )
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 15)
                            .fill(colorScheme == .dark ? Color(white: 0.2) : .white)
                            .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
                    )
                }
                
                Spacer()
                
                // Continue Button
                Button(action: {
                    // Add your continue action here
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
            .background(
                colorScheme == .dark ? Color.black : Color(red: 0.95, green: 0.95, blue: 1.0)
            )
            .navigationBarItems(leading: Button(action: {
                // Add your back action here
            }) {
                Image(systemName: "arrow.left")
                    .foregroundColor(.primary)
            })
        }
    }
}

// Preview Provider
struct TripPlanningView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            TripPlanningView()
                .preferredColorScheme(.light)
            
            TripPlanningView()
                .preferredColorScheme(.dark)
        }
    }
}
