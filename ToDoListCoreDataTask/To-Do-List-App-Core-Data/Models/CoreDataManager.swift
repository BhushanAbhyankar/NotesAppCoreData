//
//  CoreDataManager.swift
//  To-Do-List-App-Core-Data
//
//  Created by Isaiah Ojo on 28/04/2023.
//

import Foundation
import CoreData

class CoreDataManager {
    
    static let shared = CoreDataManager(modelName: "Note")

    let persistentContainer: NSPersistentContainer
    var viewContext: NSManagedObjectContext{
        return persistentContainer.viewContext
    }
    
    init(modelName: String) {
        persistentContainer = NSPersistentContainer(name: modelName)
        // Managed Object Context is like a sheet of paper torn out of a book. You can modify the contents (data) of a sheet of paper and the data wont be stored until you put it back into the book, doesnt affect your UI
    }
    
    func load(completion: (() -> Void)? = nil){
        persistentContainer.loadPersistentStores {
            (description, error) in
            guard error == nil else {
                fatalError(error!.localizedDescription)
            }
            completion?()
        }
    }
    
    func save() {
        if viewContext.hasChanges{
            do{
                try? viewContext.save()
            } catch {
                print("An Error Occured while saving: \(error.localizedDescription)")
            }
        }
    }
}

// Helper functions
extension CoreDataManager {
    func createNote() -> Note {
        let note = Note(entity: NSEntityDescription.entity(forEntityName: "Note", in: viewContext)!, insertInto: viewContext)
        note.id = UUID()
        note.text = ""
        note.lastUpdated = Date()
        save()
        
        return note
    }
   
    func fetchNotes(filter: String? = nil) -> [Note] {
        let request: NSFetchRequest<Note> = Note.fetchRequest()
        let sortDescriptor = NSSortDescriptor(keyPath: \Note.lastUpdated, ascending: false)
        request.sortDescriptors = [sortDescriptor]
        
        if let filter = filter {
            let predicate = NSPredicate(format: "text contains[cd] %@", filter)
            request.predicate = predicate
        }
        return (try? viewContext.fetch(request)) ?? []
        
        
    }
    
    func deleteNote(_ note: Note) {
        viewContext.delete(note)
        save()
    }
}
