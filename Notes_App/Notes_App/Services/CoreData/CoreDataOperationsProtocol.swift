//
//  CoreDataOperationsProtocol.swift
//  Notes_App
//
//  Created by Taijaun Pitt on 28/04/2023.
//

import Foundation
import SwiftUI

protocol CoreDataOperationsProtocol {
    
    func saveDataToDatabase(item: Note) async throws
    func getDataFromDatabase() async -> [Notes]
    func removeNote(indexSet: IndexSet, results: FetchedResults<Notes>) async
    
}
