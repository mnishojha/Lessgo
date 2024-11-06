import SwiftUI

struct DestinationPickerView: View {
    @Binding var selectedDestination: String
    let destinations: [String: [Destination]]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Destination")
                .font(.headline)
                .foregroundColor(.white)
            
            Menu {
                ForEach(Array(destinations.keys.sorted()), id: \.self) { region in
                    Menu(region) {
                        ForEach(destinations[region] ?? [], id: \.id) { dest in
                            Button(dest.name) {
                                selectedDestination = dest.name
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
                .background(
                    RoundedRectangle(cornerRadius: 15)
                        .fill(Color(white: 0.15))
                        .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: 2)
                )
            }
        }
    }
}

// DatePickerView.swift
struct DatePickerView: View {
    let title: String
    @Binding var date: Date
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.headline)
                .foregroundColor(.white)
            
            DatePicker(
                title,
                selection: $date,
                displayedComponents: .date
            )
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color(white: 0.15))
                    .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: 2)
            )
        }
    }
}
