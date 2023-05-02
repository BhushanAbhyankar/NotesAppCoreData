//
//  ContentView.swift
//  Notes_App
//
//  Created by Taijaun Pitt on 27/04/2023.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    @State var path = [Root]()
    @State private var sheetShowing = false
    
    @Environment(\.managedObjectContext) private var viewContext
    
    var fetchRequest: NSFetchRequest<Notes> = Notes.fetchRequest()
    @FetchRequest(entity: Notes.entity(), sortDescriptors: [])
    var results: FetchedResults<Notes>
    
    
    
    var coreDataManager: CoreDataManager
    
    var body: some View {
        
        NavigationStack(path: $path){
            VStack{
                List {
                    ForEach(results){ note in
                        
                        
                        NavigationLink {
                            NoteCreator(noteTitle: note.title ?? "", noteBody: note.noteBody ?? "")
                        } label: {
                            VStack{
                                Text(note.title ?? "")
                            }
                        }

                        
                        
                        
                    }.onDelete { indexSet in
                        Task {
                            await coreDataManager.removeNote2(indexSet: indexSet, results: results, context: viewContext)
                        }
                    }
                
                    
                }.scrollContentBackground(.hidden)
                .padding(20)
                Button {
                    sheetShowing.toggle()
                } label: {
                    Text("Add note")
                }.sheet(isPresented: $sheetShowing) {
                    NoteCreator(noteTitle: "", noteBody: "")
                }

                
                
            }
            

        }.navigationDestination(for: Root.self) { navigate in
            
            switch navigate {
                
            case .noteCreator:
                NoteCreator(noteTitle: "", noteBody: "")
            default:
                EmptyView()
            }
        }
        
    }
    
    enum Root{
        case noteCreator
    }
}

    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView(coreDataManager: CoreDataManager()).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
        }
    }

