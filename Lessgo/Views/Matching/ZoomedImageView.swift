//
//  ZoomedImageView.swift
//  Lessgo
//
//  Created by Israel on 11/6/24.
//

import SwiftUI

struct ZoomedImageView: View {
    let imageName: String
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack {
            Image(imageName)
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.black.edgesIgnoringSafeArea(.all))
                .onTapGesture {
                    presentationMode.wrappedValue.dismiss()
                }
        }
    }
}

#Preview {
    ZoomedImageView()
}
