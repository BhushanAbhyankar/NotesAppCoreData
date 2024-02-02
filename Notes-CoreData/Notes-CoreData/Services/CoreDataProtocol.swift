//
//  CoreDataProtocol.swift
//  Notes-CoreData
//
//  Created by Glenn Ludszuweit on 01/05/2023.
//
import Foundation
import SwiftUI

protocol CoreDataProtocol {
    func create(note: NewNote) async throws
    func read() async throws -> [Note]
    func delete(note: Note) async
}
