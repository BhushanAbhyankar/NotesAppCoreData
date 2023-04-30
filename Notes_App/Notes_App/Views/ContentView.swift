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
    
    var body: some View {
        
        NavigationStack(path: $path){
            VStack{
                List {
                    ForEach(results){ note in
                        
                        VStack{
                            Text(note.title ?? "")
                        }
                    }
                
                    
                }
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
            ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
        }
    }

