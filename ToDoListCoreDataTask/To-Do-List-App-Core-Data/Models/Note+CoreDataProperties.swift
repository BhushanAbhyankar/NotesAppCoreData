//
//  Note+CoreDataProperties.swift
//  To-Do-List-App-Core-Data
//
//  Created by Isaiah Ojo on 28/04/2023.
//
//

import Foundation
import CoreData


extension Note {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Note> {
        return NSFetchRequest<Note>(entityName: "Note")
    }

    @NSManaged public var id: UUID!
    @NSManaged public var textNameMigrate: String!
    @NSManaged public var lastUpdated: Date!
    
}

extension Note : Identifiable {

}

