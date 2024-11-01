//
//  Dateofbirth.swift
//  Lessgo
//
//  Created by manish ojha on 02/11/24.
//


import SwiftUI

struct DateOfBirthView: View {
    @State private var month = ""
    @State private var day = ""
    @State private var year = ""
    
    var body: some View {
        VStack(spacing: 32) {
            // Progress Indicator
           
          
            
            // Title
            Text("What is your date of birth?")
                .font(.system(size: 24, weight: .bold))
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 24)
            
            // Input Fields for Month, Day, Year
            HStack(spacing: 16) {
                TextField("Month", text: $month)
                    .frame(height: 60)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.white)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(10)
                
                TextField("Day", text: $day)
                    .frame(height: 60)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.white)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(10)
                
                TextField("Year", text: $year)
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
                // Action for continue button
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
        }
        .background(Color.black.edgesIgnoringSafeArea(.all))
    }
}

struct DateOfBirthView_Previews: PreviewProvider {
    static var previews: some View {
        DateOfBirthView()
            .preferredColorScheme(.dark)
    }
}
