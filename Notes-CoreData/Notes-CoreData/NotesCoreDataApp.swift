//
//  Notes_CoreDataApp.swift
//  Notes-CoreData
//
//  Created by Glenn Ludszuweit on 01/05/2023.
//

import SwiftUI

@main
struct NotesCoreDataApp: App {
    let persistenceController = PersistenceController.shared
    @Environment(\.managedObjectContext) private var viewContext

    var body: some Scene {
        WindowGroup {
            NoteListView(noteViewModel: NoteViewModel(noteManager: CoreDataManager()))
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
