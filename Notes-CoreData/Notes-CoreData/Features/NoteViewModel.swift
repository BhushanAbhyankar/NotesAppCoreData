//
//  NoteViewModel.swift
//  Notes-CoreData
//
//  Created by Glenn Ludszuweit on 01/05/2023.
//

import Foundation
import SwiftUI

struct NewNote {
    var title: String
    var body: String
    var timestamp: Date
}

class NoteViewModel: ObservableObject {
    var noteManager: CoreDataProtocol
    
    init(noteManager: CoreDataProtocol) {
        self.noteManager = noteManager
    }
    
    func saveNote(note: NewNote) async throws {
        do {
            try await noteManager.create(note: note)
        } catch let error {
            throw error
        }
    }
}
