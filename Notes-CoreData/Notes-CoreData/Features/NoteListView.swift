//
//  NoteListView.swift
//  Notes-CoreData
//
//  Created by Glenn Ludszuweit on 01/05/2023.
//

import SwiftUI
import CoreData

struct NoteListView: View {
    @State private var showForm: Bool = false
    @StateObject var noteViewModel: NoteViewModel
    @Environment(\.managedObjectContext) private var viewContext
    
    var fetchRequest: NSFetchRequest<Note> = Note.fetchRequest()
    @FetchRequest(entity: Note.entity(), sortDescriptors: [])
    var result: FetchedResults<Note>
    
    var body: some View {
        NavigationStack {
            HStack {
                Spacer()
                Image(systemName: "plus")
                    .onTapGesture {
                        showForm.toggle()
                    }
                    .sheet(isPresented: $showForm) {
                        NoteCreateView(noteViewModel: NoteViewModel(noteManager: CoreDataManager()), showForm: $showForm)
                    }
            }.padding()
            
            
            List {
                ForEach(result) { note in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(note.title ?? "")
                                .font(.headline)
                            Text(note.body ?? "")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                        Spacer()
                        Image(systemName: "xmark").padding(.trailing, 0).onTapGesture {
                            Task {
                                await noteViewModel.noteManager.delete(note: note)
                            }
                        }
                    }
                    .contentShape(Rectangle())
                }
                .task {
                    let data = try? await noteViewModel.noteManager.read()
                    print(data ?? [])
                }
            }
        }
    }
}

struct NoteListView_Previews: PreviewProvider {
    static var previews: some View {
        NoteListView(noteViewModel: NoteViewModel(noteManager: CoreDataManager()))
    }
}
