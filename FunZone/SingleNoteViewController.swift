//
//  SingleNoteViewController.swift
//  FunZone
//
//  Created by Philip Janzel Paradeza on 2022-06-05.
//

import UIKit

class SingleNoteViewController: UIViewController {

    var thisNote : Notes?
    @IBOutlet weak var noteTitleHeader: UILabel!
    @IBOutlet weak var noteBody: UITextView!
    @IBOutlet weak var noteStatusLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        noteTitleHeader.text = thisNote?.title
        noteBody.text = thisNote?.body

    }
    
    @IBAction func updateNote_BtnClicked(_ sender: Any){
        if(NotesDbHelper.dbHelper.updateNote((thisNote?.title)!, noteBody.text!, (thisNote?.user)!)){
            noteStatusLabel.textColor = UIColor.blue
            noteStatusLabel.text = "Note Updated"
            noteStatusLabel.isHidden = false
        }
        else{
            noteStatusLabel.textColor = UIColor.red
            noteStatusLabel.text = "Error in Updating Note"
            noteStatusLabel.isHidden = false
        }
        
    }
    @IBAction func undoChanges_BtnClicked(_ sender: Any){
        noteTitleHeader.text = thisNote?.title
        noteBody.text = thisNote?.body
        noteStatusLabel.isHidden = true
    }
    @IBAction func deleteNote_BtnClicked(_ sender: Any){
        
        if(NotesDbHelper.dbHelper.deleteNote((thisNote?.title)!, (thisNote?.user)!)){
            noteStatusLabel.textColor = UIColor.blue
            noteStatusLabel.text = "Note Deleted"
            noteStatusLabel.isHidden = false
            self.dismiss(animated: true)
        }
        else{
            noteStatusLabel.textColor = UIColor.red
            noteStatusLabel.text = "Error in Deleting Note"
            noteStatusLabel.isHidden = false
        }
        
    }
    override func viewDidDisappear(_ animated: Bool) {
        //NotesTableViewController.reloadData()
    }
}
