//
//  DBhelperUsers.swift
//  FunZone
//
//  Created by admin on 6/1/22.
//

import Foundation
import UIKit
import CoreData

class DBHelperUsers{
    static var dbHelper = DBHelperUsers()
    let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    
    func addUserData(usernameValue : String, passwordValue : String){
        let user = NSEntityDescription.insertNewObject(forEntityName: "Users", into: context!) as! Users
        user.username = usernameValue
        user.password = passwordValue
        do{
            try context?.save() //saves to database
            //print("data saved")
        }
        catch{
            print("data not saved")
        }
    }
    
    func getUserData() -> [Users]{
        var users = [Users]()
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Users")
        do{
            users = try context?.fetch(fetchRequest) as! [Users]
        }
        catch{
            print("can not fetch data")
        }
        return users
    }
    
    func getOneUserData(username : String) -> (userData : Users, userFlag : Bool){
        var user = Users()
        var userExists = true
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Users")
        fetchRequest.predicate = NSPredicate(format: "username == %@", username)
        fetchRequest.fetchLimit = 1
        do{
            let request = try context?.fetch(fetchRequest) as! [Users]
            if request.count != 0{
                user = request.first as! Users
                userExists = true
            }
            else{
                userExists = false
                //print("data not found")
            }
        }
        catch{
            print("error")
        }
        return (user, userExists)
    }
    
    
    func updateUserData(username : String, password : String){
        var user = Users()
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Users")
        fetchRequest.predicate = NSPredicate(format: "username == %@", username)
        do{
            let request =  try context?.fetch(fetchRequest)
            if request?.count != 0{
                user = request?.first as! Users
                user.password = password
                try context?.save()
                //print("data updated")
            }
        }
        catch{
            print("error updating data")
        }
    }
    
    func deleteData(username : String){
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Users")
        fetchRequest.predicate = NSPredicate(format : "username == %@", username)
        do{
            let user = try context?.fetch(fetchRequest)
            context?.delete(user?.first as! Users)
            try context?.save()
        }
        catch{
            print("error deleting data")
        }
    }
    
}
