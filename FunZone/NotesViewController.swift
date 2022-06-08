//
//  NotesViewController.swift
//  FunZone
//
//  Created by Philip Janzel Paradeza on 2022-06-01.
//

import UIKit

class NotesViewController: UIViewController {

    static var username : String = ""
    @IBOutlet weak var noteTitle: UITextField!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var noteErrorLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
    
        noteErrorLabel.isHidden = true
    }
    @IBAction func viewNotes_Btnclicked(_ sender: Any) {
        clearNote()
        
    }
    
    @IBAction func saveNote_BtnClicked(_ sender: Any) {
        if(NotesDbHelper.dbHelper.doesNoteExist(noteTitle.text!, NotesViewController.username))
        {
            if(NotesDbHelper.dbHelper.updateNote(noteTitle.text!, textView.text!, NotesViewController.username)){
                noteErrorLabel.textColor = UIColor.blue
                noteErrorLabel.text = "Note Updated"
                noteErrorLabel.isHidden = false
            }
            else{
                noteErrorLabel.textColor = UIColor.red
                noteErrorLabel.text = "Error in Updating Note"
                noteErrorLabel.isHidden = false
            }
            
        }
        else{
            if(NotesDbHelper.dbHelper.addNote(noteTitle.text!, textView.text!, NotesViewController.username)){
                noteErrorLabel.textColor = UIColor.blue
                noteErrorLabel.text = "Note Saved"
                noteErrorLabel.isHidden = false
            }
            else{
                noteErrorLabel.textColor = UIColor.red
                noteErrorLabel.text = "Error in Saving Note"
                noteErrorLabel.isHidden = false
            }
        }
    }
    
    @IBAction func clear_BtnClicked(_ sender: Any) {
        
        clearNote()
    }
    
    func clearNote(){
        noteTitle.text?.removeAll()
        textView.text.removeAll()
        noteErrorLabel.isHidden = true
    }
}
