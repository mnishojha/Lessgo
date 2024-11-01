//
//  AddPicView.swift
//  Lessgo
//
//  Created by manish ojha on 02/11/24.
//
import SwiftUI

struct AddPicturesView: View {
    @State private var photos: [UIImage?] = [UIImage(named: "photo1"), UIImage(named: "photo2"), nil]
    
    var body: some View {
        VStack(spacing: 32) {
            // Progress Indicator
          
            
            // Title
            Text("Add pictures of yourself")
                .font(.system(size: 24, weight: .bold))
                .foregroundColor(.white)
            
            // Photos Grid
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                ForEach(0..<photos.count, id: \.self) { index in
                    if let image = photos[index] {
                        ZStack(alignment: .topTrailing) {
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 150, height: 100)
                                .cornerRadius(10)
                                .clipped()
                            
                            // Remove button
                            Button(action: {
                                photos[index] = nil
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
                            // Action to add photo
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
                // Action for continue button
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
    }
}

struct AddPicturesView_Previews: PreviewProvider {
    static var previews: some View {
        AddPicturesView()
            .preferredColorScheme(.dark)
    }
}
