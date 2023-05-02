//
//  CoreDataManager.swift
//  Notes-CoreData
//
//  Created by Glenn Ludszuweit on 01/05/2023.
//

import Foundation
import CoreData

class CoreDataManager: CoreDataProtocol {
    let container = PersistenceController.shared.container
    
    func create(note: NewNote) async throws {
        try await container.performBackgroundTask({ viewContext in
            let entity = Note(context: viewContext)
            entity.title = note.title
            entity.body = note.body
            entity.timestamp = note.timestamp
            do {
                try viewContext.save()
            } catch let error {
                throw error
            }
        })
    }
    
    func read() async throws -> [Note] {
       try await container.performBackgroundTask({ viewContext in
            let notesRequests = Note.fetchRequest()
            do {
                let data = try viewContext.fetch(notesRequests)
                return data
            } catch let error {
                throw error
            }
        })
    }
    
    func delete(note: Note) async {
        container.viewContext.delete(note)
        try? container.viewContext.save()
    }
}
