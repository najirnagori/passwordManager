//
//  AddPasswordViewModal.swift
//  PasswordManager
//
//  Created by Najir on 15/09/24.
//

import Foundation

class AddPasswordViewModal: ObservableObject {
    @Published var passwordModal: PasswordModal = PasswordModal(accountName: "", userName: "", password: "")
    @Published var isAddButtonClicked: Bool = false
    let validator = Validator()
    @Published var alertMessage = ""
    @Published var showAlert = false
    
    func checkToAddPasswordDetails(completion: @escaping (Bool)->Void) {
        guard validator.isValidUsername(passwordModal.accountName) else {
            showAlertWithMessage("Username should be 4-20 characters long and only contain alphanumeric characters")
            return
        }
        guard validator.isValidEmail(passwordModal.userName) else {
            showAlertWithMessage("Please enter a valid email")
            return
        }
        guard validator.isValidPassword(passwordModal.password) else {
            showAlertWithMessage("Password should be of at least 8 characters, 1 uppercase, 1 lowercase, 1 digit, 1 special character")
            return
        }
        completion(true)
    }
    
    private func showAlertWithMessage(_ message: String) {
        self.alertMessage = message
        showAlert = true
        isAddButtonClicked = true
    }
    
    
}
