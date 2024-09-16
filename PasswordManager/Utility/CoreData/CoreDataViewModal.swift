//
//  CoreDataViewModal.swift
//  PasswordManager
//
//  Created by Najir on 16/09/24.
//

import Foundation
import CoreData

class CoreDataManager: ObservableObject {
    static let shared = CoreDataManager()
    
    let persistentContainer: NSPersistentContainer

    private init() {
        persistentContainer = NSPersistentContainer(name: "SavedPasswordData")
        persistentContainer.loadPersistentStores { (description, error) in
            if let error = error {
                fatalError("Unable to load persistent stores: \(error)")
            } else {
                print("Core data loaded SUccessfully")
            }
        }
    }

    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }

    // MARK: - CRUD Operations
    
    // Add Data
    func addPasswordDetails(type: PasswordModal) {
            let data = SavedPassword(context: viewContext)
            data.id = type.id
            data.userName = type.userName
            data.userType = type.accountName
            data.password = type.password
            saveContext()
    }
    
    // Delete Password Details
    func deletePasswordDetails(_ type: PasswordModal) {
        let (isExist, data) = getPasswordDetails(type)
        if !isExist {
            guard let passwordData = data?.first else {return}
            viewContext.delete(passwordData)
            saveContext()
        } else {
            print("Data is'nt exist")
        }
    }
    
    // Edit Password Details
    func editPasswordDetails(_ type: PasswordModal) {
        let (isExist, data) = getPasswordDetails(type)
        if !isExist {
            guard let passwordData = data?.first else {return}
            passwordData.id = type.id
            passwordData.userName = type.userName
            passwordData.userType = type.accountName
            passwordData.password = type.password
            saveContext()
        } else {
            print("Phrase is'nt in learned state")
        }
    }
    
    // Check Data Existence
    func getPasswordDetails(_ type: PasswordModal) -> (Bool, [SavedPassword]?) {
        let fetchRequest: NSFetchRequest<SavedPassword> = SavedPassword.fetchRequest()
            fetchRequest.predicate = NSPredicate(
                format: "id == %@", type.id as CVarArg
            )
        
        do {
            let data = try viewContext.fetch(fetchRequest)
            return (data.isEmpty, data)
        } catch {
            print("Failed to fetch: \(error)")
            return (true, nil)
        }
    }
    
    
    
    // Read All Data
    func fetchPasswordData() -> [PasswordModal] {
        let fetchRequest: NSFetchRequest<SavedPassword> = SavedPassword.fetchRequest()
        do {
            let data = try viewContext.fetch(fetchRequest)
            var passwordData: [PasswordModal] = []
            for result in data {
                passwordData.append(PasswordModal(
                    id: result.id,
                    accountName: result.userType,
                    userName: result.userName,
                    password: result.password)
                )
            }
            return passwordData
        } catch {
            print("Failed to fetch items: \(error)")
            return []
        }
    }
    
    // Save
    func saveContext() {
        if viewContext.hasChanges {
            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}
