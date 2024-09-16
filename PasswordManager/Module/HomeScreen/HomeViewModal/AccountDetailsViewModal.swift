//
//  AccountDetailsViewModal.swift
//  PasswordManager
//
//  Created by Najir on 15/09/24.
//

import Foundation

class AccountDetailsViewModal: ObservableObject {
    
    @Published var isOnEdit: Bool = false
    @Published var isAddButtonClicked: Bool = false
    @Published var accountName: String = ""
    @Published var userName: String = ""
    @Published var password: String = ""
    @Published var showDeleteAlert: Bool = false
    @Published var showAlert = false
    @Published var alertMessage = ""
    
    var validator = Validator()

    
    func checkToAddPasswordDetails(completion: @escaping (Bool)->Void) {
        guard validator.isValidUsername(accountName) else {
            showAlertWithMessage("Username should be 4-20 characters long and only contain alphanumeric characters")
            return
        }
        guard validator.isValidEmail(userName) else {
            showAlertWithMessage("Please enter a valid email")
            return
        }
        guard validator.isValidPassword(password) else {
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

enum PasswordDetailType {
    case accountType, userName, password
}
