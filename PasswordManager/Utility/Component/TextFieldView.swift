//
//  TextFieldView.swift
//  PasswordManager
//
//  Created by Najir on 13/09/24.
//

import SwiftUI

struct TextFieldView: View {
    let placeholder: String
    @Binding var text: String
    @Binding var isAddButtonCliked: Bool
    var body: some View {
        TextField(placeholder, text: $text)
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

#Preview {
    TextFieldView(
        placeholder: "Hello",
        text: .constant(""),
        isAddButtonCliked: .constant(false)
    )
}
