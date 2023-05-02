//
//  NotesScreen.swift
//  NotesApp
//
//  Created by Hamzah Azam on 01/05/2023.
//

import SwiftUI

struct NotesScreen: View {
    
    @State var notesTitle: String
    @State var notesBody: String
    @Environment(\.dismiss) var dismiss

    let noteScreenViewModel = NoteScreenViewModel()
    
    var body: some View {
        VStack{
            TextField("Enter Title", text: $notesTitle).padding()
                .textFieldStyle(.roundedBorder)
            
            RoundedRectangle(cornerRadius: 10).frame(width: 330, height: 300).padding()
                .overlay(TextEditor(text: $notesBody).border(.black))
            
            
        
            Button {
                Task{
                    await noteScreenViewModel.saveNote(title: notesTitle, body: notesBody, timeStamp: .now)
                    guard let url = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).first else {return}
                    let sqlitePath = url.appendingPathComponent("NotesApp.sqlite")
                    print(sqlitePath)
                }
                dismiss()
            } label: {
                Text("Save changes").textFieldStyle(.roundedBorder)
            }
        }
    }
}


struct NotesScreen_Previews: PreviewProvider {
    static var previews: some View {
        NotesScreen(notesTitle: "", notesBody: "")
    }
}
