//
//  SavedPassword+CoreDataProperties.swift
//  PasswordManager
//
//  Created by Najir on 16/09/24.
//
//

import Foundation
import CoreData


extension SavedPassword {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SavedPassword> {
        return NSFetchRequest<SavedPassword>(entityName: "SavedPassword")
    }

    @NSManaged public var id: UUID
    @NSManaged public var userName: String
    @NSManaged public var userType: String
    @NSManaged public var password: String

}

extension SavedPassword : Identifiable {

}
