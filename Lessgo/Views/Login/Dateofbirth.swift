import SwiftUI

struct DateOfBirthView: View {
    @ObservedObject var viewModel: ContentViewModel
    @State private var month: String = ""
    @State private var day: String = ""
    @State private var year: String = ""
    @State private var errorMessage: String = ""

    var onNext: () -> Void

    var body: some View {
        GeometryReader { geometry in
            VStack {
                Spacer(minLength: geometry.size.height * 0.1)

                Text("What is your date of birth?")
                    .font(.system(size: 26, weight: .bold))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 24)

                HStack(spacing: 16) {
                    CustomTextField(placeholder: "MM", text: $month, maxLength: 2)
                    CustomTextField(placeholder: "DD", text: $day, maxLength: 2)
                    CustomTextField(placeholder: "YYYY", text: $year, maxLength: 4)
                }
                .padding(.top, 16)
                .padding(.horizontal, 24)

                if !errorMessage.isEmpty {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .font(.footnote)
                        .padding(.top, 8)
                        .transition(.opacity)
                }

                Spacer()

                Button(action: validateAndContinue) {
                    Text("Continue")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 52)
                        .background((month.isEmpty || day.isEmpty || year.isEmpty) ? Color.gray : Color.blue)
                        .cornerRadius(26)
                        .padding(.horizontal, 24)
                }
                .disabled(month.isEmpty || day.isEmpty || year.isEmpty)

                Spacer(minLength: geometry.size.height * 0.08)
            }
            .background(Color.black.edgesIgnoringSafeArea(.all))
        }
    }

    private func validateAndContinue() {
        withAnimation {
            guard let dob = createDateFromInputs() else {
                errorMessage = "Please enter a valid date."
                return
            }

            let age = calculateAge(from: dob)
            if age < 18 {
                errorMessage = "You must be at least 18 years old."
            } else {
                viewModel.dateOfBirth = dob
                errorMessage = ""
                onNext()
            }
        }
    }

    private func createDateFromInputs() -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter.date(from: "\(month)/\(day)/\(year)")
    }

    private func calculateAge(from birthDate: Date) -> Int {
        Calendar.current.dateComponents([.year], from: birthDate, to: Date()).year ?? 0
    }
}

struct CustomTextField: View {
    let placeholder: String
    @Binding var text: String
    let maxLength: Int

    var body: some View {
        TextField(placeholder, text: $text)
            .keyboardType(.numberPad)
            .frame(width: 80, height: 50)
            .multilineTextAlignment(.center)
            .padding()
            .background(Color.white.opacity(0.1))
            .cornerRadius(12)
            .foregroundColor(.white)
            .font(.system(size: 18, weight: .medium))
            .onChange(of: text) { oldValue, newValue in
                text = String(newValue.prefix(maxLength).filter(\.isNumber))
            }
    }
}

struct DateOfBirthView_Previews: PreviewProvider {
    static var previews: some View {
        DateOfBirthView(viewModel: ContentViewModel()) {}
            .preferredColorScheme(.dark)
    }
}
