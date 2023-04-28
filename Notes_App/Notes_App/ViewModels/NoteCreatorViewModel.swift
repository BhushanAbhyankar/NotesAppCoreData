import Foundation
import CoreData

class NoteCreatorViewModel: ObservableObject {
    
    
    
    func saveNote(title: String, body: String, timeStamp: Date) async {
        
        let newNote = Note(body: body, timeStamp: timeStamp, title: title)
        
        let coreDataManager = CoreDataManager()
        
        do {
            try await coreDataManager.saveDataToDatabase(item: newNote)
        } catch let error {
            print(error.localizedDescription)
        }
        
        
    }
    
    
    
}
