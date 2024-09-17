//
//  NoteCreateView.swift
//  Notes-CoreData
//
//  Created by Glenn Ludszuweit on 01/05/2023.
//

import SwiftUI

struct NoteCreateView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @StateObject var noteViewModel: NoteViewModel
    @Binding var showForm: Bool
    @State private var title: String = ""
    @State private var desc: String = ""
    
    private func save() async throws {
        let note = NewNote(title: title, body: desc, timestamp: Date())
        do {
            try await noteViewModel.saveNote(note: note)
        } catch let error {
            throw error
        }
        title = ""
        desc = ""
        
        guard let url = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).first else {return}
        
        let sqlitePath = url.appendingPathComponent("Notes_CoreData.sqlite")
        print(sqlitePath)
    }
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Image(systemName: "xmark")
                    .onTapGesture {
                        showForm.toggle()
                    }
            }.padding()
            
            TextField("Title", text: $title).textFieldStyle(.roundedBorder)
            
            ZStack {
                TextEditor(text: $desc).background(Color.primary.colorInvert())
                    .cornerRadius(5)
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(.black, lineWidth: 1 / 3)
                            .opacity(0.3)
                    )
            }
            
            Button {
                Task {
                    try await save()
                    showForm.toggle()
                }
            } label: {
                Text("Save Note").frame(maxWidth: .infinity)
            }.buttonStyle(.borderedProminent).tint(.gray)
        }.padding()
            .navigationBarTitle("Create a Note")
    }
}

struct NoteCreateView_Previews: PreviewProvider {
    static var previews: some View {
        NoteCreateView(noteViewModel: NoteViewModel(noteManager: CoreDataManager()), showForm: .constant(false))
    }
}
