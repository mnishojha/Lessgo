import SwiftUI

struct TripPlanningView: View {
    @State private var destination: String = ""
    @State private var arrivalDate: Date = Date()
    @State private var departureDate: Date = Date()
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 24) {
                // Title
                Text("Do you have an upcoming trip?")
                    .font(.system(size: 32, weight: .bold))
                    .foregroundColor(.white)
                    .padding(.top, 16)
                
                // Destination section using custom picker
                DestinationPickerView(selectedDestination: $destination, destinations: destinationsByRegion)
                
                // Date section with custom date pickers
                DatePickerView(title: "Arrival Date", date: $arrivalDate)
                DatePickerView(title: "Departure Date", date: $departureDate)
                
                Spacer()
                
                // Continue Button with custom style
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
            .background(Color.black.edgesIgnoringSafeArea(.all))
            .navigationBarItems(leading: Button(action: {
                // Add your back action here
            }) {
                Image(systemName: "arrow.left")
                    .foregroundColor(.white)
            })
        }
    }
}

// Preview Provider
struct TripPlanningView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            TripPlanningView()
                .preferredColorScheme(.dark)
        }
    }
}
