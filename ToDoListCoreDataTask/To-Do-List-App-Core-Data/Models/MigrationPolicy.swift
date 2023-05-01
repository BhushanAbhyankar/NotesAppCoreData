//
//  MigrationPolicy.swift
//  To-Do-List-App-Core-Data
//
//  Created by Isaiah Ojo on 01/05/2023.
//

import Foundation
import CoreData

class NoteMigrationPolicy: NSEntityMigrationPolicy {
    override func createDestinationInstances(forSource sourceInstance: NSManagedObject, in mapping: NSEntityMapping, manager: NSMigrationManager) throws {
        guard let text = sourceInstance.value(forKey: "text") as? String else {
            throw NSError(domain: "com.yourdomain", code: 1, userInfo: nil)
        }
        guard let id = sourceInstance.value(forKey: "id") as? UUID else {
            throw NSError(domain: "com.yourdomain", code: 2, userInfo: nil)
        }
        guard let lastUpdated = sourceInstance.value(forKey: "lastUpdated") as? Date else {
            throw NSError(domain: "com.yourdomain", code: 3, userInfo: nil)
        }

        let destination = NSEntityDescription.insertNewObject(forEntityName: "Note", into: manager.destinationContext)

        destination.setValue(text, forKey: "text")
        destination.setValue(id, forKey: "id")
        destination.setValue(lastUpdated, forKey: "lastUpdated")

        manager.associate(sourceInstance: sourceInstance, withDestinationInstance: destination, for: mapping)
    }
}
