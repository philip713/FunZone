//
//  Notes+CoreDataProperties.swift
//  FunZone
//
//  Created by Philip Janzel Paradeza on 2022-06-01.
//
//

import Foundation
import CoreData


extension Notes {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Notes> {
        return NSFetchRequest<Notes>(entityName: "Notes")
    }

    @NSManaged public var title: String?
    @NSManaged public var body: String?
    @NSManaged public var user: String?

}

extension Notes : Identifiable {

}
