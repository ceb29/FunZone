//
//  Users+CoreDataProperties.swift
//  FunZone
//
//  Created by admin on 5/31/22.
//
//

import Foundation
import CoreData


extension Users {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Users> {
        return NSFetchRequest<Users>(entityName: "Users")
    }

    @NSManaged public var username: String?
    @NSManaged public var password: String?

}

extension Users : Identifiable {

}
