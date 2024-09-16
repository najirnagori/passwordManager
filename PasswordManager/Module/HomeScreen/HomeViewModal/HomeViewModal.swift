//
//  HomeViewModal.swift
//  PasswordManager
//
//  Created by Najir on 15/09/24.
//

import Foundation

class HomeViewModal: ObservableObject {
    @Published var passwordsDatails: [PasswordModal] = []
    @Published var currentPasswordIndex: Int = -1
    
    init() {
        self.passwordsDatails = CoreDataManager.shared.fetchPasswordData()
    }
    
//    func didFinishAddingResult(result: PasswordModal) {
//        self.passwordsDatails.append(result)
//        print(passwordsDatails)
//    }
    
}
