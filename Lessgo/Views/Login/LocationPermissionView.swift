import SwiftUI

struct LocationPermissionView: View {
    @ObservedObject var viewModel: ContentViewModel
    var onNext: () -> Void
    
    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            Spacer()
            
            Image(systemName: "map.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 100)
                .foregroundColor(.white)
            
            Text("Turn on Location Services")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
            
            Text("To view nearby travelers and find travel plans, your location is needed. You can disable this at any time.")
                .font(.body)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 30)
            
            Spacer()
            
            Button(action: {
                viewModel.isLocationPermissionGranted = true
                onNext()
            }) {
                HStack {
                    Text("Continue to Lessgo")
                    Image(systemName: "arrow.right")
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
            }
            .padding(.horizontal, 20)
        }
        .padding()
        .background(Color.black.edgesIgnoringSafeArea(.all))
        .navigationBarBackButtonHidden(true)
    }
}

struct LocationPermissionView_Previews: PreviewProvider {
    static var previews: some View {
        LocationPermissionView(viewModel: ContentViewModel(), onNext: {})
            .preferredColorScheme(.dark)
    }
}
