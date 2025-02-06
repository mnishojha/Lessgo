//
//  DateOfBirthView.swift
//  Lessgo
//
//  Created by Manish Ojha on 02/11/24.
//

import SwiftUI

// ContentViewModel to store user input
class ContentViewModel: ObservableObject {
    @Published var dateOfBirth: Date? = nil
    @Published var errorMessage: String = ""
}

struct DateOfBirthView: View {
    @ObservedObject var viewModel: ContentViewModel
    @State private var month = ""
    @State private var day = ""
    @State private var year = ""

    var onNext: () -> Void

    var body: some View {
        VStack(spacing: 32) {
            // Title
            Text("What is your date of birth?")
                .font(.system(size: 24, weight: .bold))
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 24)

            // Input Fields for Month, Day, Year
            HStack(spacing: 16) {
                TextField("MM", text: $month)
                    .keyboardType(.numberPad)
                    .textFieldStyle(PlainTextFieldStyle()) // Proper styling
                    .frame(width: 80, height: 60) // Set width
                    .multilineTextAlignment(.center)
                    .foregroundColor(.white)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(10)

                TextField("DD", text: $day)
                    .keyboardType(.numberPad)
                    .textFieldStyle(PlainTextFieldStyle())
                    .frame(width: 80, height: 60)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.white)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(10)

                TextField("YYYY", text: $year)
                    .keyboardType(.numberPad)
                    .textFieldStyle(PlainTextFieldStyle())
                    .frame(width: 100, height: 60)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.white)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(10)
            }
            .padding(.horizontal, 24)

            Spacer()

            // Continue Button
            Button(action: {
                if let dateOfBirth = createDateFromInputs() {
                    viewModel.dateOfBirth = dateOfBirth // Save valid date
                    viewModel.errorMessage = "" // Clear error
                    onNext() // Proceed
                } else {
                    viewModel.errorMessage = "Please enter a valid date."
                }
            }) {
                Text("Continue")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background(Color.blue)
                    .cornerRadius(25)
                    .padding(.horizontal, 24)
            }

            // Error message
            if !viewModel.errorMessage.isEmpty {
                Text(viewModel.errorMessage)
                    .foregroundColor(.red)
                    .padding(.top)
            }
        }
        .padding(.top, 20)
        .background(Color.black.edgesIgnoringSafeArea(.all))
    }

    // Helper function to validate and create a Date from inputs
    private func createDateFromInputs() -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        let dateString = "\(month)/\(day)/\(year)"

        if let date = formatter.date(from: dateString) {
            return date
        } else {
            return nil // Return nil if date is invalid
        }
    }
}

struct DateOfBirthView_Previews: PreviewProvider {
    static var previews: some View {
        DateOfBirthView(viewModel: ContentViewModel()) {
            // Sample onNext action
        }
        .preferredColorScheme(.dark)
    }
}
   
