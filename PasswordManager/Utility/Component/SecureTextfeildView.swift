//
//  SecureTextfeildView.swift
//  PasswordManager
//
//  Created by Najir on 15/09/24.
//

import SwiftUI

struct PasswordFieldView: View {
    let placeholder: String
    @Binding var text: String
    @Binding var isAddButtonCliked: Bool
    @State private var isPasswordVisible: Bool = false

    var body: some View {
        HStack {
            if isPasswordVisible {
                TextField("Enter Password", text: $text)
                
            } else {
                SecureField("Enter Password", text: $text)
            }
            
            Button(action: {
                isPasswordVisible.toggle()
            }) {
                Image(systemName: isPasswordVisible ? "eye.fill" : "eye.slash.fill")
                    .foregroundStyle(isPasswordVisible ? .black : .primaryGray)
            }
        }
        .padding()
        .background(.white)
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(
                    text.isEmpty && isAddButtonCliked ? Color.buttonRed : Color.borderColor,
                    lineWidth: 0.5
                )
        )
    }
}

//struct PasswordFieldView_Previews: PreviewProvider {
//    static var previews: some View {
//        PasswordFieldView(password: .constant(""))
//    }
//}
