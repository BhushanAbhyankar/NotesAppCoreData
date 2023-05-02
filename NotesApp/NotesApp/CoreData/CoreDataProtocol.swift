//
//  CoreDataProtocol.swift
//  NotesApp
//
//  Created by Hamzah Azam on 01/05/2023.
//

import Foundation
import SwiftUI

protocol CoreDataProtocol {
    func saveDataToDatabase(item: Note) async throws
    func getDataFromDatabase() async -> [Notes]
    func deleteNote(indexSet: IndexSet, results: FetchedResults <Notes>) async
}
