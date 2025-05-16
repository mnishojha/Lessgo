//
//  WhereView.swift
//  Lessgo
//
//  Created by manish ojha on 02/11/24.
//

import SwiftUI

struct CountrySelectionView: View {
    @ObservedObject var viewModel: ContentViewModel
    @State private var selectedCountry = "India"
    let countries = ["Australia", "United States", "Canada", "India", "United Kingdom"]
    
    var onNext: () -> Void
    
    var body: some View {
        VStack(spacing: 32) {
            // Title
            Text("Where are you from?")
                .font(.system(size: 24, weight: .bold))
                .foregroundColor(.white)
            
            Text("Let's know your country of residence")
                .font(.system(size: 16))
                .foregroundColor(.gray)
            
            // Country Picker
            Menu {
                ForEach(countries, id: \.self) { country in
                    Button(action: {
                        selectedCountry = country
                    }) {
                        Text(country)
                    }
                }
            } label: {
                HStack {
                    Image(systemName: "flag.fill")
                        .foregroundColor(.white)
                    Text(selectedCountry)
                        .foregroundColor(.white)
                    Spacer()
                    Image(systemName: "chevron.down")
                        .foregroundColor(.white)
                }
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
                .padding(.horizontal, 24)
            }
            
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
    }
}

struct CountrySelectionView_Previews: PreviewProvider {
    static var previews: some View {
        CountrySelectionView(viewModel: ContentViewModel()) {
            // Sample onNext action
        }
        .preferredColorScheme(.dark)
    }
}
