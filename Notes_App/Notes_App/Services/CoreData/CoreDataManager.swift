//
//  CoreDataManager.swift
//  Notes_App
//
//  Created by Taijaun Pitt on 28/04/2023.
//

import Foundation
import CoreData


class CoreDataManager: CoreDataOperationsProtocol {
    
    
    func saveDataToDatabase(item: Note) async throws {
        
        try await PersistenceController.shared.container.performBackgroundTask{ (privateContext) in
            
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
        
        await PersistenceController.shared.container.performBackgroundTask({ (privateContext) in
            
            let notesFetchRequest = Notes.fetchRequest()
            let result = (try? privateContext.fetch(notesFetchRequest)) ?? []
            return result
            
        })
        
    }
    
    
}
