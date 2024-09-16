//
//  CustomSheetView.swift
//  PasswordManager
//
//  Created by Najir on 13/09/24.
//

import SwiftUI


struct CustomSheetView<Content: View>: View {
    @Binding var isPresented: Bool
    var sheetTitle: String?
//    var cancelButtonImage: Image = .xMarkIcon
   
    var withBlurBG: Bool = false
    @ViewBuilder var content: Content
    
    @State var showBottomSheet: Bool = false
    @State private var dragOffset = CGSize.zero
    
    var body: some View {
        ZStack(alignment: .bottom) {
            backgroundView
            
            if showBottomSheet {
                bottomSheetView
                    .transition(
                        .asymmetric(
                            insertion: .move(edge: .bottom),
                            removal: .move(edge: .bottom)
                        )
                    )
            }
        }
        .frame(
            maxWidth: .infinity,
            maxHeight: .infinity
        )
        .onChange(
            of: isPresented,
            perform: onDismiss(_:)
        )
        .onReceive(
            NotificationCenter.default.publisher(
                for: .init(rawValue: NotificationKeys.dismissSheetKey)))
        { _ in
            dismissSheet()
        }
        .navigationBarTitle("") // this must be empty
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
}

extension CustomSheetView {
    
    @ViewBuilder
    private var backgroundView: some View {
        if withBlurBG {
            TransparentBlurView()
                .ignoresSafeArea()
                .onAppear {
                    withAnimation(.easeInOut(duration: 0.2)) {
                        showBottomSheet = true
                    }
                }
                .onTapGesture {
                    dismissSheet()
                }
        } else {
            Color.black.opacity(isPresented ? 0.5 : 0.0)
                .transition(.opacity)
                .ignoresSafeArea()
                .onAppear {
                    withAnimation(.easeInOut(duration: 0.2)) {
                        showBottomSheet = true
                    }
                }
                .onTapGesture {
                    dismissSheet()
                }
        }
    }
    
    @ViewBuilder
    private var bottomSheetView: some View {
        VStack {
            Spacer()
            
            VStack(spacing: .zero) {
                RoundedRectangle(cornerRadius: 50)
                    .foregroundStyle(Color.primeGray)
                    .frame(width: 60, height: 5)
                    .padding()
//                dismissButtonView
                
                // Content to show on sheet
                content
            }
            .frame(maxWidth: .infinity)
            .background {
                    RoundedCornerShape(
                        corners: [.topLeft, .topRight],
                        radius: 10
                    )
                    .fill(Color.sheetBackgroundColor)
                        .ignoresSafeArea()
            }
        }
        .frame(maxHeight: UIScreen.main.bounds.height * 0.85)
        .offset(y: dragOffset.height)
        .gesture(
            DragGesture(minimumDistance: 30)
                .onChanged(onChanges(newValue:))
                .onEnded(onEnd(newValue:))
        )
    }
    
//    @ViewBuilder
//    private var dismissButtonView: some View {
//        if showCancelButton {
//            HStack {
//                Button {
//                    dismissSheet()
//                } label: {
//                    cancelButtonImage
//                        .padding(20)
//                        .contentShape(Rectangle())
//                }
//                .buttonStyle(.plain)
//                
//                Spacer()
//            }
//        }
//    }
    
    private func onChanges(newValue: DragGesture.Value) {
        if (newValue.location.y - newValue.startLocation.y) > 0 {
            dragOffset = newValue.translation
        }
    }
    private func onEnd(newValue: DragGesture.Value) {
        if newValue.translation.height > 100 {
            dismissSheet()
        } else {
            withAnimation {
                self.dragOffset = .zero
            }
        }
    }
    
    private func onDismiss(_ newValue: Bool) {
        if newValue == false {
            dismissSheet()
        }
    }
    
    private func dismissSheet() {
        withAnimation(.easeOut(duration: 0.2)) {
            showBottomSheet = false
            isPresented = false
        }
    }
}

