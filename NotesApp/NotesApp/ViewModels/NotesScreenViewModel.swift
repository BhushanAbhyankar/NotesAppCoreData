//
//  NotesScreenViewModel.swift
//  NotesApp
//
//  Created by Hamzah Azam on 01/05/2023.
//

import Foundation
import CoreData

class NoteScreenViewModel: ObservableObject {

    func saveNote(title: String, body: String, timeStamp: Date) async {
        let coreDataManager = CoreDataManager()
        let newNote = Note(body: body, title: title, timeStamp: timeStamp)
        do {
            try await coreDataManager.saveDataToDatabase(item: newNote)
        }
        catch let error {
            print(error.localizedDescription)
        }
    }
}
