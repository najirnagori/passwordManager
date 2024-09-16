//
//  AddPasswordView.swift
//  PasswordManager
//
//  Created by Najir on 13/09/24.
//

import SwiftUI

struct AddPasswordView: View {
    @ObservedObject var addPasswordVM: AddPasswordViewModal = AddPasswordViewModal()
    @Binding var passwordsDetails: [PasswordModal]
    @Binding var isOpenSheet: Bool
    var body: some View {
        VStack {
            TextFieldView(
                placeholder: "Account Name",
                text: $addPasswordVM.passwordModal.accountName,
                isAddButtonCliked: $addPasswordVM.isAddButtonClicked
            )
            .padding([.horizontal, .top])
            TextFieldView(
                placeholder: "Username/ Email",
                text: $addPasswordVM.passwordModal.userName,
                isAddButtonCliked: $addPasswordVM.isAddButtonClicked
            )
            .padding([.horizontal, .top])
            PasswordFieldView(
                placeholder: "Password",
                text: $addPasswordVM.passwordModal.password,
                isAddButtonCliked: $addPasswordVM.isAddButtonClicked
            )
            .padding([.horizontal, .top])
            ThemeButtonView(
                buttonTitle: "Add New Account",
                buttonColor: .buttonBlack
            ) {
                addPasswordVM.checkToAddPasswordDetails { isTrue in
                    if isTrue {
                        CoreDataManager.shared.addPasswordDetails(type: addPasswordVM.passwordModal)
                        passwordsDetails.append(addPasswordVM.passwordModal)
                        isOpenSheet = false
                    }
                }
            }

        }
        .alert("Alert", isPresented: $addPasswordVM.showAlert) {
            Button("Ok") {}
        } message: {
            Text(addPasswordVM.alertMessage)
        }

        
    }
}

#Preview {
    AddPasswordView(passwordsDetails: .constant([]), isOpenSheet: .constant(false))
}
