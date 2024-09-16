//
//  AccountDetailsView.swift
//  PasswordManager
//
//  Created by Najir on 15/09/24.
//

import SwiftUI

struct AccountDetailsView: View {
    @ObservedObject var accountDetailsVM: AccountDetailsViewModal = AccountDetailsViewModal()
    @Binding var passwordsDetails: [PasswordModal]
    @Binding var index: Int
    @Binding var isSheetOpen: Bool
    @State var isShowPassword: Bool = false
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            titleText
            details("Account Type", passwordDetailType: .accountType)
            details("Username/ Email", passwordDetailType: .userName)
            passwordView
            buttons
        }
        .padding()
        .alert("Alert", isPresented: $accountDetailsVM.showDeleteAlert) {
            Button("Delete", role: .destructive) {
                isSheetOpen = false
                DispatchQueue.main.asyncAfter(deadline: .now()+0.3) {
                    CoreDataManager.shared.deletePasswordDetails(passwordsDetails[index])
                    passwordsDetails.remove(at: index)
                }
            }
            Button("Cancle", role: .cancel) {
                
            }
        } message: {
            Text("Are you sure! do you want to delete it?")
        }
        .alert("Alert", isPresented: $accountDetailsVM.showAlert) {
            Button("Ok") {}
        } message: {
            Text(accountDetailsVM.alertMessage)
        }
    }
}

//#Preview {
//    AccountDetailsView()
//}

extension AccountDetailsView {
    private var titleText: some View {
        Text("Account Details")
            .fontWeight(.bold)
            .foregroundStyle(.primeBlue)
            .padding(.bottom)
    }
    
    private func details(_ title: String, passwordDetailType: PasswordDetailType) -> some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(title)
                .font(.system(size: 12))
                .fontWeight(.light)
            if accountDetailsVM.isOnEdit {
                switch passwordDetailType {
                case .accountType:
                    TextFieldView(
                        placeholder: title,
                        text: $accountDetailsVM.accountName,
                        isAddButtonCliked: $accountDetailsVM.isAddButtonClicked
                    )
                case .userName:
                    TextFieldView(
                        placeholder: title,
                        text: $accountDetailsVM.userName,
                        isAddButtonCliked: $accountDetailsVM.isAddButtonClicked
                    )
                case .password:
                    PasswordFieldView(
                        placeholder: title,
                        text: $accountDetailsVM.password,
                        isAddButtonCliked: $accountDetailsVM.isAddButtonClicked
                    )
                }
            } else {
                switch passwordDetailType {
                case .accountType:
                    Text(passwordsDetails[index].accountName)
                        .font(.system(size: 20))
                        .fontWeight(.bold)
                case .userName:
                    Text(passwordsDetails[index].userName)
                        .font(.system(size: 20))
                        .fontWeight(.bold)
                case .password:
                    Text(isShowPassword ? passwordsDetails[index].password : "********")
                        .font(.system(size: 20))
                        .fontWeight(.bold)
                }
            }
        }
    }
    
    private var passwordView: some View {
        HStack {
            details("Password", passwordDetailType: .password )
            Spacer()
            if !accountDetailsVM.isOnEdit {
                Button {
                    isShowPassword.toggle()
                } label: {
                    Image(systemName: isShowPassword ? "eye.fill" : "eye.slash.fill")
                        .foregroundStyle(isShowPassword ? .black : .primaryGray)
                }
                .offset(y: 5)
            }

        }
    }
    
    private var buttons: some View {
        HStack {
            if accountDetailsVM.isOnEdit {
                ThemeButtonView(
                    buttonTitle: "Save Changes",
                    buttonColor: .buttonBlack
                ) {
                    accountDetailsVM.checkToAddPasswordDetails { isTrue in
                        if isTrue {
                            passwordsDetails[index].userName = accountDetailsVM.userName
                            passwordsDetails[index].accountName = accountDetailsVM.accountName
                            passwordsDetails[index].password = accountDetailsVM.password
                            CoreDataManager.shared.editPasswordDetails(passwordsDetails[index])
                            isSheetOpen = false
                        }
                    }
                }
            } else {
                ThemeButtonView(
                    buttonTitle: "Edit",
                    buttonColor: .buttonBlack
                ) {
                    accountDetailsVM.userName = passwordsDetails[index].userName
                    accountDetailsVM.accountName = passwordsDetails[index].accountName
                    accountDetailsVM.password = passwordsDetails[index].password
                    accountDetailsVM.isOnEdit = true
                }
                ThemeButtonView(
                    buttonTitle: "Delete",
                    buttonColor: .buttonRedColor
                ) {
                    accountDetailsVM.showDeleteAlert = true
                }
            }
        }
    }
}
