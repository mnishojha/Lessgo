import Foundation
import SwiftUI

struct ReviewAndSubmitView: View {
    @ObservedObject var viewModel: ContentViewModel
    var onSubmit: () -> Void
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Review Your Information")
                .font(.title)
                .foregroundColor(.white)
            
            // Display all fields
            VStack(alignment: .leading, spacing: 10) {
                Text("Email: \(viewModel.email)")
                Text("Date of Birth: \(viewModel.dateOfBirth, formatter: dateFormatter)")
                Text("Location: \(viewModel.location)")
                Text("Interests: \(viewModel.interests.joined(separator: ", "))")
                Text("Language: \(viewModel.language)")
            }
            .foregroundColor(.white)
            
            // Submit button
            Button(action: onSubmit) {
                Text("Submit")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
        .padding()
        .background(Color.black.edgesIgnoringSafeArea(.all)) // Optional background styling
    }
    
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }
}

struct ReviewAndSubmitView_Previews: PreviewProvider {
    static var previews: some View {
        ReviewAndSubmitView(viewModel: ContentViewModel()) {
            print("Submitted!")
        }
        .preferredColorScheme(.dark) // Preview in dark mode
    }
}
