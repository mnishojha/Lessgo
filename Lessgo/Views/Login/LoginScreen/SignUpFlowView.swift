import SwiftUI

struct SignUpFlowView: View {
    @ObservedObject var viewModel: ContentViewModel // Shared ViewModel
    @State private var currentStep = 1 // Tracks the current step of the flow
    
    var body: some View {
        VStack {
            Spacer()
            
            // Show the current step's view
            Group {
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
                    LanguageSelectionView(viewModel: viewModel) {
                        goToNextStep()
                    }
                case 6:
                    ReviewAndSubmitView(viewModel: viewModel) {
                        submitSignup()
                    }
                default:
                    Text("Something went wrong.")
                }
            }
            .transition(.slide)
            
            Spacer()
            
            // Step indicator and controls
            HStack {
                if currentStep > 1 {
                    Button(action: goToPreviousStep) {
                        Text("Back")
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(10)
                    }
                }
                
                if currentStep < 6 {
                    Button(action: goToNextStep) {
                        Text("Next")
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
            }
            .padding(.horizontal, 20)
            .animation(.default, value: currentStep)
        }
        .padding()
        .background(Color.black.edgesIgnoringSafeArea(.all))
        .navigationBarBackButtonHidden(true) // Disable back navigation
    }
    
    private func goToNextStep() {
        withAnimation {
            currentStep += 1
        }
    }
    
    private func goToPreviousStep() {
        withAnimation {
            currentStep -= 1
        }
    }
    
    private func submitSignup() {
        viewModel.signUpUser() // Save data to Firebase
    }
}

struct SignUpFlowView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpFlowView(viewModel: ContentViewModel())
    }
}
