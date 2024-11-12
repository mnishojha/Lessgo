//
//  Dateofbirth.swift
//  Lessgo
//
//  Created by manish ojha on 02/11/24.
//

import SwiftUI

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
                TextField("Month", text: $month)
                    .keyboardType(.numberPad)
                    .frame(height: 60)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.white)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(10)
                
                TextField("Day", text: $day)
                    .keyboardType(.numberPad)
                    .frame(height: 60)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.white)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(10)
                
                TextField("Year", text: $year)
                    .keyboardType(.numberPad)
                    .frame(height: 60)
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
                    viewModel.dateOfBirth = dateOfBirth // Save to ViewModel
                    onNext() // Proceed to the next step
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
        .background(Color.black.edgesIgnoringSafeArea(.all))
    }
    
    // Helper function to validate and create a Date from the entered inputs
    private func createDateFromInputs() -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        let dateString = "\(month)/\(day)/\(year)"
        return formatter.date(from: dateString)
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
