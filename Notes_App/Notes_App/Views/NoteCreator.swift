//
//  NoteCreator.swift
//  Notes_App
//
//  Created by Taijaun Pitt on 28/04/2023.
//

import SwiftUI

struct NoteCreator: View {
    @Environment(\.dismiss) var dismiss
    
    @State var noteTitle: String
    @State var noteBody: String
    let noteCreatorViewmodel = NoteCreatorViewModel(manager: CoreDataManager())
    
    
    var body: some View {
        
        VStack{
            
            TextField("Enter Title", text: $noteTitle)
                .textFieldStyle(.roundedBorder)
                .padding()
                .padding(.top, 50)
            
            RoundedRectangle(cornerRadius: 15)
                .frame(width: 350, height: 350)
                .overlay(TextEditor(text: $noteBody)
                    .border(.black))
            
            
            
            
            
            Button {
                Task{
                    await noteCreatorViewmodel.saveNote(title: noteTitle, body: noteBody, timeStamp: .now)
                    
                    // Print the db file path
                    guard let url = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).first else {return}
                    
                    let sqlitePath = url.appendingPathComponent("Notes_App.sqlite")
                    print(sqlitePath)
                }
                dismiss()
            } label: {
                Text("Done")
            }

        }
        
    }
}

struct NoteCreator_Previews: PreviewProvider {
    static var previews: some View {
        NoteCreator(noteTitle: "Title", noteBody: "This is the body of the note, and will contain all the text the user has entered")
    }
}
