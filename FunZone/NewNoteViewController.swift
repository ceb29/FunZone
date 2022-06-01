//
//  NewNoteViewController.swift
//  FunZone
//
//  Created by admin on 5/28/22.
//

import UIKit

class NewNoteViewController: UIViewController {
    let userDefault = UserDefaults.standard
    @IBOutlet weak var saveCheckmark: UIImageView!
    @IBOutlet weak var deleteCheckmark: UIImageView!
    @IBOutlet weak var noteTitle: UITextField!
    @IBOutlet weak var noteContent: UITextView!
    @IBOutlet weak var resultLabel: UILabel!
    var newNoteStatus = true
    var currentTitle = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        noteContent.layer.cornerRadius = 10
        noteContent.layer.masksToBounds = true
        //getCurrentText()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        getCurrentText()
    }
    
    @IBAction func saveClicked(_ sender: Any) {
        if currentTitle != noteTitle.text!{
            newNoteStatus = true
        }
        if newNoteStatus{
            let note = DBHelperNotes.dbHelper.getOneNoteData(title: noteTitle.text!)
            if note.noteFlag{ //note with title already exists
                print("note title already exists")
                resultLabel.text = "Title Already Exists"
            }
            else{
                DBHelperNotes.dbHelper.addNoteData(titleValue: noteTitle.text!, contentValue: noteContent.text!)
                newNoteStatus = false
                 //create new note and save into new notes id
                print("saveNew")
                print(note.noteFlag)
                saveCheckmark.isHidden = false
            }
            
        }
        else{
            DBHelperNotes.dbHelper.updateNoteData(title: noteTitle.text!, content: noteContent.text!)
            print("saveUpdate")
            saveCheckmark.isHidden = false
        }
    }
    
    @IBAction func deleteClicked(_ sender: Any) {
        if !newNoteStatus{
            newNoteStatus = true
            deleteCheckmark.isHidden = false
            DBHelperNotes.dbHelper.deleteData(title: currentTitle)
        }
    }
    
    func getCurrentText(){
        newNoteStatus = userDefault.bool(forKey: "newNote")
        //print(newNoteStatus)
        if !newNoteStatus{
            currentTitle = userDefault.string(forKey: "noteTitle")!
            let note = DBHelperNotes.dbHelper.getOneNoteData(title:  currentTitle)
            noteTitle.text = currentTitle
            noteContent.text = note.noteData.content!
        }
    }
    
}
