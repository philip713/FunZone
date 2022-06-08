//
//  UserDBHelper.swift
//  FunZone
//
//  Created by Philip Janzel Paradeza on 2022-06-01.
//

import Foundation
import UIKit
import CoreData

class UserDBHelper{
    
    static var dbHelper = UserDBHelper()
    let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    
    func addUser (_ user : String, _ pass : String) -> Bool{
        let newUser = NSEntityDescription.insertNewObject(forEntityName: "User", into: context!) as! User
        newUser.username = user
        newUser.password = pass
        do{
            try context?.save()
            print("User Registered")
            return true
        }
        catch{
            print("Error in saving user to core data")
            return false
        }
    }
    
    func doesUserExist_Register(_ user : String) -> Bool{
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        fetchRequest.predicate = NSPredicate(format: "username == %@", user)
        do{
            let request = try context?.fetch(fetchRequest)
            if(request?.count != 0)
            {
                print("User Exist")
                return true
            }
            else
            {
                print("User Doesn't Exist")
                return false
            }
        }
        catch{
            print("Error in finding user")
            return true
        }
    }
    
    func doesUserExist_Login(_ user : String) -> Bool{
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        fetchRequest.predicate = NSPredicate(format: "username == %@", user)
        do{
            let request = try context?.fetch(fetchRequest)
            if(request?.count != 0)
            {
                print("User Exist")
                return true
            }
            else
            {
                print("User Doesn't Exist")
                return false
            }
        }
        catch{
            print("Error in finding user")
            return false
        }
    }
    
    func isPasswordCorrect(_ user : String, _ pass : String) -> Bool{
        var myUser = User()
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        fetchRequest.predicate = NSPredicate(format: "username == %@", user)
        do{
            let request = try context?.fetch(fetchRequest)
            if(request?.count != 0){
                myUser = request?.first as! User
                if(myUser.password == pass)
                {
                    print("password correct")
                    return true
                }
                else{
                    print("password incorrect")
                    return false
                }
            }
            else{
                print("user not found")
                return false
            }
        }
        catch{
            print("Error in fetching data")
            return false
        }
    }
}
