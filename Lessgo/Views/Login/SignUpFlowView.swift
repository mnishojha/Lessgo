//
//  SignUpFlowView.swift
//  Lessgo
//
//  Created by Israel on 11/6/24.
//

import SwiftUI

struct SignUpFlowView: View {
    @ObservedObject var viewModel: ContentViewModel // Accept viewModel as a parameter
    @State private var currentStep = 1
    
    var body: some View {
        VStack {
            switch currentStep {
            case 1:
                DateOfBirthView(viewModel: viewModel) {
                    goToNextStep()
                }
            case 2:
                CountrySelectionView(viewModel: viewModel) {
                    goToNextStep()
                }
            case 3:
                AddPicturesView(viewModel: viewModel) {
                    goToNextStep()
                }
            case 4:
                InterestView(viewModel: viewModel) {
                    goToNextStep()
                }
            case 5:
                TripPlanningView(viewModel: viewModel) {
                    goToNextStep()
                }
            case 6:
                LanguageSelectionView(viewModel: viewModel) {
                    goToNextStep()
                }
            default:
                LoginView()
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

