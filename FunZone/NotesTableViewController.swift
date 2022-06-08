//
//  NotesTableViewController.swift
//  FunZone
//
//  Created by Philip Janzel Paradeza on 2022-06-05.
//

import UIKit
import CoreData

class NotesTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    var noteList : [Notes]?
    var username : String?
    @IBOutlet weak var noteTableHeader: UILabel!
    @IBOutlet weak var notesListTable: UITableView!
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return noteList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! NoteTableViewCell
        cell.noteCellLabel.text = noteList![indexPath.row].title
        return cell
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        username = NotesViewController.username
        noteTableHeader.text = username! + "'s saved notes"
        noteList = NotesDbHelper.dbHelper.getAllUserNotes(username!)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let noteStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let noteScreenVC = noteStoryboard.instantiateViewController(withIdentifier: "SingleNote") as! SingleNoteViewController
        noteScreenVC.thisNote = noteList![indexPath.row]
        self.present(noteScreenVC, animated: true, completion: nil)

    }
    
    static func reload(){
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {

        if editingStyle == .delete {
            // remove the item from the data model
            
            if(NotesDbHelper.dbHelper.deleteNote(noteList![indexPath.row].title!, username!)){
                //delete from noteList array
                noteList?.remove(at: indexPath.row)
                // delete the table view row
                tableView.deleteRows(at: [indexPath], with: .fade)
//                noteList = NotesDbHelper.dbHelper.getAllUserNotes(username!)
//                print(noteList?.count)
            }
        }
        else{
        }
    }
}
