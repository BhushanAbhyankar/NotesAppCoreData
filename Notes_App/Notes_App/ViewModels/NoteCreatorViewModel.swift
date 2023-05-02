import Foundation
import CoreData

class NoteCreatorViewModel: ObservableObject {
    
    var manager: CoreDataOperationsProtocol
    
    init(manager: CoreDataOperationsProtocol) {
        self.manager = manager
    }
    
    
    func saveNote(title: String, body: String, timeStamp: Date) async {
        
        let newNote = Note(body: body, timeStamp: timeStamp, title: title)
        
        
        do {
            try await manager.saveDataToDatabase(item: newNote)
        } catch let error {
            print(error.localizedDescription)
        }
        
        
    }
    
    
    
}
