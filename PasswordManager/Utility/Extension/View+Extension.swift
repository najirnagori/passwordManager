//
//  View+Extension.swift
//  PasswordManager
//
//  Created by Najir on 13/09/24.
//

import SwiftUI

extension View {
    
    // 
    func showCustomSheet<V: View>(isPresented: Binding<Bool>, @ViewBuilder contentView: () -> V) -> some View {
        modifier(
            SheetViewModifier(
                isPresented: isPresented,
                sheetView: contentView()
            )
        )
    }
}
