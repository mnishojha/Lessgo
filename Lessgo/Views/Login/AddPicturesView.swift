import SwiftUI
import UniformTypeIdentifiers




struct AddPicturesView: View {
    @ObservedObject var viewModel: ContentViewModel
    @State private var showFileImporter = false
    @State private var selectedImageIndex: Int?

    var onNext: () -> Void

    var body: some View {
        VStack(spacing: 32) {
            Text("Add pictures of yourself")
                .font(.system(size: 24, weight: .bold))
                .foregroundColor(.white)

            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                ForEach(viewModel.photos.indices, id: \.self) { index in
                    if let image = viewModel.photos[index] {
                        ZStack(alignment: .topTrailing) {
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(width: 150, height: 100)
                                .cornerRadius(10)
                                .clipped()

                            Button(action: {
                                viewModel.photos[index] = nil
                            }) {
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundColor(.white)
                                    .background(Color.black.opacity(0.6))
                                    .clipShape(Circle())
                                    .padding(4)
                            }
                        }
                    } else {
                        Button(action: {
                            selectedImageIndex = index
                            showFileImporter = true
                        }) {
                            ZStack {
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color.gray.opacity(0.2))
                                    .frame(width: 150, height: 100)

                                Image(systemName: "plus")
                                    .font(.system(size: 24, weight: .bold))
                                    .foregroundColor(.blue)
                            }
                        }
                    }
                }
            }
            .padding(.horizontal, 24)

            Spacer()

            Button(action: {
                onNext()
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
        .padding(.top, 20)
        .background(Color.black.edgesIgnoringSafeArea(.all))
        .fileImporter(
            isPresented: $showFileImporter,
            allowedContentTypes: [UTType.image],
            allowsMultipleSelection: false
        ) { result in
            switch result {
            case .success(let urls):
                if let url = urls.first,
                   let imageData = try? Data(contentsOf: url),
                   let uiImage = UIImage(data: imageData),  // ✅ UIKit-based UIImage
                   let index = selectedImageIndex {
                    viewModel.photos[index] = Image(uiImage: uiImage) // ✅ Convert UIImage to SwiftUI Image
                }
            case .failure(let error):
                print("Error selecting file: \(error.localizedDescription)")
            }
        }
    }
}

struct AddPicturesView_Previews: PreviewProvider {
    static var previews: some View {
        AddPicturesView(viewModel: ContentViewModel()) {}
            .preferredColorScheme(.dark)
    }
}
