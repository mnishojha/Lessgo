//
//  CustomFields.swift
//  Lessgo
//
//  Created by Israel on 11/6/24.
//

import SwiftUI

struct CustomTextFields: View {
    @Binding var text: String
    let placeholder: String
    @Binding var isFocused: Bool
    
    var body: some View {
        ZStack(alignment: .leading) {
            if text.isEmpty {
                Text(placeholder)
                    .foregroundColor(.gray)
                    .padding(.horizontal, 10)
                    .offset(y: isFocused ? -25 : 0)
                    .scaleEffect(isFocused ? 0.8 : 1, anchor: .leading)
            }
            
            TextField("", text: $text) { focused in
                withAnimation(.easeInOut(duration: 0.2)) {
                    isFocused = focused
                }
            }
            .foregroundColor(.white)
            .padding(10)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(isFocused ? Color.white : Color.gray, lineWidth: 1)
            )
        }
    }
}

struct CustomSecureField: View {
    @Binding var text: String
    let placeholder: String
    @Binding var isFocused: Bool
    @Binding var showPassword: Bool
    
    var body: some View {
        ZStack(alignment: .leading) {
            if text.isEmpty {
                Text(placeholder)
                    .foregroundColor(.gray)
                    .padding(.horizontal, 10)
                    .offset(y: isFocused ? -25 : 0)
                    .scaleEffect(isFocused ? 0.8 : 1, anchor: .leading)
            }
            
            HStack {
                if showPassword {
                    TextField("", text: $text)
                } else {
                    SecureField("", text: $text)
                }
                
                Button(action: {
                    showPassword.toggle()
                }) {
                    Image(systemName: showPassword ? "eye.slash.fill" : "eye.fill")
                        .foregroundColor(.gray)
                }
            }
            .foregroundColor(.white)
            .padding(10)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(isFocused ? Color.white : Color.gray, lineWidth: 1)
            )
        }
        .onTapGesture {
            withAnimation(.easeInOut(duration: 0.2)) {
                isFocused = true
            }
        }
    }
}
