//
//  File.swift
//  FunZone
//
//  Created by admin on 5/31/22.
//

import Foundation
import UIKit
import CoreData

class DBHelperNotes{
    static var dbHelper = DBHelperNotes()
    let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    
    
    
    func addNoteData(titleValue : String, contentValue : String){
        let note = NSEntityDescription.insertNewObject(forEntityName: "Note", into: context!) as! Note
        note.title = titleValue
        note.content = contentValue
        do{
            try context?.save() //saves to database
            print("data saved")
        }
        catch{
            print("data not saved")
        }
    }
    
    func getNoteData() -> [Note]{
        var note = [Note]()
        var fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")
        do{
            note = try context?.fetch(fetchRequest) as! [Note]
        }
        catch{
            print("can not fetch data")
        }
        return note
    }
    
    func getOneNoteData(title : String) -> (noteData : Note, noteFlag : Bool){
        var note = Note()
        var noteExists = true
        var fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")
        fetchRequest.predicate = NSPredicate(format: "title == %@", title)
        fetchRequest.fetchLimit = 1
        do{
            let request = try context?.fetch(fetchRequest) as! [Note]
            if request.count != 0{
                note = request.first as! Note
                noteExists = true
            }
            else{
                print("data not found")
                noteExists = false
            }
        }
        catch{
            print("error")
        }
        return (note, noteExists)
    }
    
    
    func updateNoteData(title : String, content : String){
        var note = Note()
        var fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")
        fetchRequest.predicate = NSPredicate(format: "title == %@", title)
        do{
            let request =  try context?.fetch(fetchRequest)
            if request?.count != 0{
                note = request?.first as! Note
                note.content = content
                try context?.save()
                print("data updated")
            }
        }
        catch{
            print("error updating data")
        }
    }
    
    func deleteData(title : String){
        var fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")
        fetchRequest.predicate = NSPredicate(format : "title == %@", title)
        do{
            let note = try context?.fetch(fetchRequest)
            context?.delete(note?.first as! Note)
            try context?.save()
        }
        catch{
            print("error deleting data")
        }
    }
    
}
