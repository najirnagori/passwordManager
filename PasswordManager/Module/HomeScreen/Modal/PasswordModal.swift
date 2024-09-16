//
//  PasswordModal.swift
//  PasswordManager
//
//  Created by Najir on 15/09/24.
//

import Foundation

struct PasswordModal: Identifiable {
    var id = UUID()
    var accountName: String
    var userName: String
    var password: String
}
