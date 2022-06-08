//
//  User+CoreDataProperties.swift
//  FunZone
//
//  Created by Philip Janzel Paradeza on 2022-06-01.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var username: String?
    @NSManaged public var password: String?

}

extension User : Identifiable {

}
