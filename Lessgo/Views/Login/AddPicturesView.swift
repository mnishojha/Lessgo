import SwiftUI
import UIKit // ✅ Fix: Import UIKit for UIImage

struct AddPicturesView: View {
    @ObservedObject var viewModel: ContentViewModel
    @State private var showImagePicker = false
    @State private var selectedImageIndex: Int?

    var onNext: () -> Void

    var body: some View {
        VStack(spacing: 32) {
            // Title
            Text("Add pictures of yourself")
                .font(.system(size: 24, weight: .bold))
                .foregroundColor(.white)

            // Photos Grid
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                ForEach(viewModel.photos.indices, id: \.self) { index in // ✅ Fix: Corrected ForEach binding
                    if let image = viewModel.photos[index] { // ✅ Fix: No $
                        ZStack(alignment: .topTrailing) {
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 150, height: 100)
                                .cornerRadius(10)
                                .clipped()

                            // Remove button
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
                            showImagePicker = true
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

            // Continue Button
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
        .sheet(isPresented: $showImagePicker) {
            if let index = selectedImageIndex {
                ImagePicker(selectedImage: $viewModel.photos[index]) // ✅ Fix: Corrected image picker binding
            } else {
                ImagePicker(selectedImage: .constant(nil)) // ✅ Fix: Prevents crash when index is nil
            }
        }
    }
}

// ImagePicker View for selecting images
struct ImagePicker: UIViewControllerRepresentable {
    @Binding var selectedImage: UIImage?

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.sourceType = .photoLibrary
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: ImagePicker

        init(_ parent: ImagePicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            if let image = info[.originalImage] as? UIImage {
                parent.selectedImage = image
            }
            picker.dismiss(animated: true)
        }
    }
}

struct AddPicturesView_Previews: PreviewProvider {
    static var previews: some View {
        AddPicturesView(viewModel: ContentViewModel()) {
            // Sample onNext action
        }
        .preferredColorScheme(.dark)
    }
}
