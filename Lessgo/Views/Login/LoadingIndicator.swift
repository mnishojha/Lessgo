//
//  LoadingIndicator.swift
//  Lessgo
//
//  Created by Israel on 11/6/24.
//

import SwiftUI

// Enhanced loading indicator with black-and-white theme
struct LoadingIndicator: View {
    @State private var isLoading = false
    
    var body: some View {
        ZStack {
            Circle()
                .trim(from: 0, to: 0.7)
                .stroke(
                    AngularGradient(
                        gradient: Gradient(colors: [
                            Color.white.opacity(0.3),
                            Color.white
                        ]),
                        center: .center
                    ),
                    style: StrokeStyle(lineWidth: 3, lineCap: .round)
                )
                .frame(width: 35, height: 35)
                .rotationEffect(Angle(degrees: isLoading ? 360 : 0))
                .animation(
                    Animation.linear(duration: 1)
                        .repeatForever(autoreverses: false),
                    value: isLoading
                )
                .onAppear() {
                    self.isLoading = true
                }
        }
    }
}
