import SwiftUI


class DOBViewModel: ObservableObject {
    @Published var dateOfBirth: Date?
    @Published var errorMessage: String = ""
}


struct DateOfBirthView: View {
    @ObservedObject var viewModel: DOBViewModel
    @State private var month: String = ""
    @State private var day: String = ""
    @State private var year: String = ""
    
    var onNext: () -> Void

    var body: some View {
        VStack(spacing: 32) {
            Text("What is your date of birth?")
                .font(.system(size: 24, weight: .bold))
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 24)

            // Date input fields
            HStack(spacing: 16) {
                CustomTextField(placeholder: "MM", text: $month, maxLength: 2)
                CustomTextField(placeholder: "DD", text: $day, maxLength: 2)
                CustomTextField(placeholder: "YYYY", text: $year, maxLength: 4)
            }
            .padding(.horizontal, 24)

            Spacer()

            Button(action: validateAndContinue) {
                Text("Continue")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background(Color.blue)
                    .cornerRadius(25)
                    .padding(.horizontal, 24)
            }
            .disabled(month.isEmpty || day.isEmpty || year.isEmpty)

            if !viewModel.errorMessage.isEmpty {
                Text(viewModel.errorMessage)
                    .foregroundColor(.red)
                    .padding(.top)
            }
        }
        .padding(.top, 20)
        .background(Color.black.edgesIgnoringSafeArea(.all))
    }

   
    private func validateAndContinue() {
        guard let dob = createDateFromInputs() else {
            viewModel.errorMessage = "Please enter a valid date."
            return
        }

        let age = calculateAge(from: dob)
        if age < 18 {
            viewModel.errorMessage = "You must be at least 18 years old."
        } else {
            viewModel.dateOfBirth = dob
            viewModel.errorMessage = ""
            onNext()
        }
    }

    private func createDateFromInputs() -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        return formatter.date(from: "\(month)/\(day)/\(year)")
    }

    private func calculateAge(from birthDate: Date) -> Int {
        let now = Date()
        let calendar = Calendar.current
        let ageComponents = calendar.dateComponents([.year], from: birthDate, to: now)
        return ageComponents.year ?? 0
    }
}


struct CustomTextField: View {
    let placeholder: String
    @Binding var text: String
    let maxLength: Int

    var body: some View {
        TextField(placeholder, text: $text)
            .keyboardType(.numberPad)
            .padding()
            .background(Color.gray.opacity(0.2))
            .cornerRadius(10)
            .onChange(of: text) { oldValue, newValue in
                text = String(newValue.prefix(maxLength).filter(\.isNumber))
            }
    }
}


struct DateOfBirthView_Previews: PreviewProvider {
    static var previews: some View {
        DateOfBirthView(viewModel: DOBViewModel()) {}
            .preferredColorScheme(.dark)
    }
}
