//
//  ContentView.swift
//  NotesApp
//
//  Created by Hamzah Azam on 01/05/2023.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    var coreDataManager: CoreDataManager
    @Environment(\.managedObjectContext) private var viewContext
    
    var fetchRequest: NSFetchRequest<Notes> = Notes.fetchRequest()
    @FetchRequest(entity: Notes.entity(), sortDescriptors: [])
    var results: FetchedResults<Notes>
    
    @State var path = [Root]()
    @State private var sheetShowing = false
    @State private var searchText = ""
    
    var body: some View {
        NavigationStack(path: $path){
            VStack{
                List {
                    ForEach(results){ note in
                        NavigationLink {
                            NotesScreen(notesTitle: note.title ?? "no title", notesBody: note.body ?? "no body")
                        } label: {
                            Text(note.title ?? "")
                        }
                        
                    }.onDelete { indexSet in
                        Task {
                            await coreDataManager.deleteNote2(indexSet: indexSet, results: results, context: viewContext)
                        }
                    }
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            sheetShowing.toggle()
                        } label: {
                            Image(systemName: "plus")
                        }.sheet(isPresented: $sheetShowing) {
                            NotesScreen(notesTitle: "", notesBody: "")
                        }
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        EditButton()
                    }
                }
                
                Button {
                    sheetShowing.toggle()
                } label: {
                    Text("Add New Note")
                }.sheet(isPresented: $sheetShowing) {
                    NotesScreen(notesTitle: "", notesBody: "")
                }
                
            }.navigationTitle("My notes")
            
        }.searchable(text: $searchText, prompt: "Look for something")
//        {
//            ForEach(results) { result in
//                Text("Are you looking for \(result)?").searchCompletion(result)
//            }
//            var results: [String] {
//                    if searchText.isEmpty {
//                        return note
//                    } else {
//                        return note.filter { $0.contains(searchText) }
//                    }
//                }
//        }
        .navigationDestination(for: Root.self) { navigate in
            
            
            switch navigate {
                
            case .notesScreen:
                NotesScreen(notesTitle: "", notesBody: "")
            default:
                EmptyView()
            }
        }
        
    }
    
    enum Root{
        case notesScreen
    }
}


//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
//    }
//}
