//
//  CountryCard.swift
//  Lessgo
//
//  Created by Israel on 11/6/24.
//

import SwiftUI

struct CountryCard: View {
    let image: String
    
    var body: some View {
        Image(image)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(height: 150)
            .clipped()
            .cornerRadius(16)
    }
}


#Preview {
    CountryCard()
}
