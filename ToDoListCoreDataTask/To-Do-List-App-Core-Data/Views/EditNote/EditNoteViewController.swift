//
//  EditNoteViewController.swift
//  To-Do-List-App-Core-Data
//
//  Created by Isaiah Ojo on 28/04/2023.
//

import UIKit

class EditNoteViewController: UIViewController {
    
    static let identifier = "EditNoteViewController"
    
    var note: Note!
    weak var delegate: ListNotesDelegate?

    @IBOutlet weak private var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textView.text = note?.textNameMigrate
    }
    
    override func viewDidAppear(_ animated: Bool) {
        textView.becomeFirstResponder()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // MARK:- Methods to implement
    private func updateNote() {
        // TODO update the note in database
        print("Updating note")
        
        note.lastUpdated = Date()
        CoreDataManager.shared.save()
        delegate?.refreshNotes()
    }
    
    private func deleteNote() {
        // TODO delete the note from database
        print("Deleting note")
        delegate?.deleteNote(with: note.id)
        CoreDataManager.shared.deleteNote(note)

    }
}

// MARK:- UITextView Delegate

// This function waits until the user finishes editing before saving the note. This is a delegate that prevents the UI from slowing down
extension EditNoteViewController: UITextViewDelegate {
    func textViewDidEndEditing(_ textView: UITextView) {
        note?.textNameMigrate = textView.text
        if note?.title.isEmpty ?? true {
            deleteNote()
        } else {
            updateNote()
        }
    }
}
