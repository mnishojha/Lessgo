//
//  ProfileView.swift
//  Lessgo
//
//  Created by Israel on 10/29/24.
//

import SwiftUI

struct ProfileView: View {
    
    @State private var userName = "John"
    @State private var photos: [String] = [
        "photo 1", "photo 2", "photo 3", "photo 4", "photo 5" //ADD PHOTO LSTER
    ]
    
    var body: some View {
        VStack{
            Text("Welcome, \(userName)")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top, 20)
                .padding(.leading, 20)

            //photos here
            ScrollView{
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 10){
                    ForEach(photos, id: \.self){ photo in
                        Image(photo)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 200, height: 200)
                            .cornerRadius(10)
                            .clipped()
                    }
                }
                .padding(.horizontal, 20)
            }
        }
    }
}

#Preview {
    ProfileView()
}
