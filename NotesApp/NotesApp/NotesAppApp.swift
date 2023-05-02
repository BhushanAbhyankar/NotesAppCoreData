//
//  NotesAppApp.swift
//  NotesApp
//
//  Created by Hamzah Azam on 01/05/2023.
//

import SwiftUI

@main
struct NotesAppApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView( coreDataManager: CoreDataManager())
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
