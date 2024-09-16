//
//  ThemeButtonView.swift
//  PasswordManager
//
//  Created by Najir on 13/09/24.
//

import SwiftUI

struct ThemeButtonView: View {
    let buttonTitle: String
    let buttonColor: Color
    let action: (()->Void)
    var body: some View {
        Button {
            action()
        } label: {
            RoundedRectangle(cornerRadius: 50)
                .stroke(lineWidth: 0)
                .background(buttonColor)
                .cornerRadius(50)
                .frame(height: 50)
                .overlay {
                    Text(buttonTitle)
                        .foregroundStyle(.white)
                        .fontWeight(.bold)
                }
        }
        .padding()
        .padding(.top)
        .shadow(color: .gray, radius: 5, x: 0, y: 1)
    }
}

#Preview {
    ThemeButtonView(
        buttonTitle: "add new color",
        buttonColor: .buttonBlack
    ) {}
}
