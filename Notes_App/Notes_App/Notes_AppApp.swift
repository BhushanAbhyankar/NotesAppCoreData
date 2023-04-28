//
//  Notes_AppApp.swift
//  Notes_App
//
//  Created by Taijaun Pitt on 27/04/2023.
//

import SwiftUI

@main
struct Notes_AppApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
