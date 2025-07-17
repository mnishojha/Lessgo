import SwiftUI

struct SignUpFlowView: View {
    @ObservedObject var viewModel: ContentViewModel
    @State private var currentStep = 1

    var body: some View {
        VStack {
            Spacer()

            Group {
                switch currentStep {
                
                case 2:
                    DateOfBirthView(viewModel: viewModel, onNext: goToNextStep)
                case 3:
                    CountrySelectionView(viewModel: viewModel, onNext: goToNextStep)
                case 4:
                    InterestView(viewModel: viewModel, onNext: goToNextStep)
                case 5:
                    LanguageSelectionView(viewModel: viewModel, onNext: goToNextStep)
                case 6:
                    LocationPermissionView(viewModel: viewModel, onNext: goToNextStep)
                case 7:
                    NavigationLink(destination: LoginView()) {
                        Text("Go to Login")
                            .font(.headline)
                            .foregroundColor(.blue)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(10)
                    }
                default:
                    Text("Something went wrong.")
                        .foregroundColor(.white)
                }
            }
            .transition(.slide)

            Spacer()

            HStack(spacing: 16) {
                if currentStep > 1 && currentStep <= 6 {
                    Button(action: goToPreviousStep) {
                        Text("Back")
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(10)
                            .foregroundColor(.white)
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
        .navigationBarBackButtonHidden(true)
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
}

struct SignUpFlowView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpFlowView(viewModel: ContentViewModel())
            .preferredColorScheme(.dark)
    }
}
