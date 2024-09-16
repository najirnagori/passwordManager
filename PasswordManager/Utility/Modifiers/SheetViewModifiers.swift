//
//  SheetViewModifiers.swift
//  PasswordManager
//
//  Created by Najir on 13/09/24.
//


import SwiftUI

// MARK: Custom Sheet View Modifier
struct SheetViewModifier<T: View>: ViewModifier {
    @Binding var isPresented: Bool
    let sheetView: T
    
    func body(content: Content) -> some View {
        content
            .overlay {
                if isPresented {
                    CustomSheetView(
                        isPresented: $isPresented
                    ) {
                        sheetView
                    }
                }
            }
    }
}
