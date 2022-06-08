//
//  NotesDbHelper.swift
//  FunZone
//
//  Created by Philip Janzel Paradeza on 2022-06-01.
//

import Foundation
import UIKit
import CoreData

class NotesDbHelper{
    
    static var dbHelper = NotesDbHelper()
    let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    
    func doesNoteExist(_ title : String, _ user : String) -> Bool{
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Notes")
        fetchRequest.predicate = NSPredicate(format: "title == %@ AND user == %@", title, user)
        do{
            let request = try context?.fetch(fetchRequest)
            if(request?.count != 0)
            {
                print("Note Exists")
                return true
            }
            else{
                print("Note doesn't exist")
                return false
            }
        }
        catch{
            print("Error finding note")
            return false
        }
    }
    
    func addNote(_ title : String, _ body : String, _ user : String) -> Bool{
        let newNote = NSEntityDescription.insertNewObject(forEntityName: "Notes", into: context!) as! Notes
        newNote.title = title
        newNote.body = body
        newNote.user = user
        do{
            try context?.save()
            print("Note Saved")
            return true
        }
        catch{
            print("Error in saving note to core data")
            return false
        }
    }
    func getAllUserNotes(_ user : String) -> [Notes]{
        var notes = [Notes]()
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Notes")
        fetchRequest.predicate = NSPredicate(format: "user == %@", user)
        do{
            notes = try context?.fetch(fetchRequest) as! [Notes]
            print("data fetched")
        }
        catch{
            print("cannot fetch data")
        }
        return notes
    }
    
    func getSelectedNote(_ title : String,_ user : String) -> Notes{
        var myNote = Notes()
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Notes")
        fetchRequest.predicate = NSPredicate(format: "title == %@", title)
        fetchRequest.fetchLimit = 1
        do{
            let request = try context?.fetch(fetchRequest)
            if(request?.count != 0){
                myNote = request?.first as! Notes
                print("Note found")
            }
            else{
                print("Note not found")
            }
            
        }
        catch{
            print("Error in fetching data")
        }
        return myNote
    }
    
    func updateNote(_ title : String,_ body: String, _ user : String) -> Bool{
        var myNote = Notes()
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Notes")
        fetchRequest.predicate = NSPredicate(format: "title == %@ AND user == %@", title, user)
        do{
            let request = try context?.fetch(fetchRequest)
            if(request?.count != 0){
                myNote = request?.first as! Notes
                myNote.body = body
                try context?.save()
                print("Note updated")
                return true
            }
            else{
                print("Note not found")
                return false
            }
        }
        catch{
            print("error in updating note")
            return false
        }
    }
    
    func deleteNote(_ title : String,_ user : String) -> Bool{
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Notes")
        fetchRequest.predicate = NSPredicate(format: "title == %@ AND user == %@", title, user)
        do{
            let myNote = try context?.fetch(fetchRequest)
            if(myNote?.count != 0)
            {
                context?.delete(myNote?.first as! Notes)
                try context?.save()
                print("Note deleted")
                return true
            }
            else{
                print("Note not found")
                return false
            }
        }
        catch{
            print("error in deleting note")
            return false
        }
    }
    
    
}
