//
//  CoreDataManager.swift
//  Notes_App
//
//  Created by Taijaun Pitt on 28/04/2023.
//

import Foundation
import CoreData
import SwiftUI


class CoreDataManager: CoreDataOperationsProtocol {
    
    let context = PersistenceController.shared.container
    
    
    func saveDataToDatabase(item: Note) async throws {
        
        try await context.performBackgroundTask{ (privateContext) in
            
            let entity = Notes(context: privateContext)
            entity.title = item.title
            entity.noteBody = item.body
            entity.timeStamp = item.timeStamp
            
            
            do {
                try privateContext.save()
                print("Data saved")
                
            } catch let error {
                print(error.localizedDescription)
                throw error
                
            }
        }
        
    }
    
    func getDataFromDatabase() async -> [Notes] {
        
        await context.performBackgroundTask({ (privateContext) in
            
            let notesFetchRequest = Notes.fetchRequest()
            let result = (try? privateContext.fetch(notesFetchRequest)) ?? []
            return result
            
        })
        
    }
    
    func removeNote(indexSet: IndexSet, results: FetchedResults<Notes>) async {
        
        
        await context.performBackgroundTask({ (privateContext) in
            
            guard let index = indexSet.first else {return}
            let entity = results[index]
            privateContext.delete(entity)
            
            try? privateContext.save()
        })
        
    }
    
    func removeNote2(indexSet: IndexSet, results: FetchedResults<Notes>, context: NSManagedObjectContext) async {
        
        
        guard let index = indexSet.first else {return}
        let entity = results[index]
        context.delete(entity)
        
        try? context.save()
        
    }
    
    
}
