//
//  Note+CoreDataProperties.swift
//  FunZone
//
//  Created by admin on 5/31/22.
//
//

import Foundation
import CoreData


extension Note {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Note> {
        return NSFetchRequest<Note>(entityName: "Note")
    }

    @NSManaged public var title: String?
    @NSManaged public var content: String?

}

extension Note : Identifiable {

}
