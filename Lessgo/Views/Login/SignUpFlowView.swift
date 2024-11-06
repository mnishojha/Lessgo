//
//  SignUpFlowView.swift
//  Lessgo
//
//  Created by Israel on 11/6/24.
//

import SwiftUI

struct SignUpFlowView: View {
    @State private var currentStep = 1
    @State private var dateOfBirth = Date()
    @State private var location = ""
    // Add other properties to store data from each step as needed

    var body: some View {
        VStack {
            switch currentStep {
            case 1:
                DateOfBirthView()
            case 2:
                CountrySelectionView()
            // Add cases for other steps here, e.g., PictureUploadView, InterestsView, etc.
            default:
                ContentView() // Or the final destination view after completing the flow
            }
        }
        .transition(.slide)
    }

    func goToNextStep() {
        withAnimation {
            currentStep += 1
        }
    }
}

#Preview {
    SignUpFlowView()
}
