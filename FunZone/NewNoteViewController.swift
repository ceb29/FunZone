//
//  NewNoteViewController.swift
//  FunZone
//
//  Created by admin on 5/28/22.
//

import UIKit

class NewNoteViewController: UIViewController {
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
    
    func addNewNote(){
        //create new note and save into new notes id
        DBHelperNotes.dbHelper.addNoteData(titleValue: noteTitle.text!, contentValue: noteContent.text!)
        newNoteStatus = false
        currentTitle = noteTitle.text!
    }
    
    func deleteNote(){
        DBHelperNotes.dbHelper.deleteData(title: currentTitle)
        newNoteStatus = true
    }
    
    @IBAction func saveClicked(_ sender: Any) {
        //if title of saved note has changed, delete note and set new note status to true
        if currentTitle != noteTitle.text! && !newNoteStatus{
            deleteNote()
            currentTitle = noteTitle.text!
            newNoteStatus = true
        }
        //if new note status is true, add new note
        //else update saved note
        if newNoteStatus{
            //get note data for title
            let note = DBHelperNotes.dbHelper.getOneNoteData(title: noteTitle.text!)
            //check if note with title already exists
            if note.noteFlag{
                //display that note with title already exists
                resultLabel.text = "Title Already Exists"
            }
            else{
                //add new note and display save checkmark
                addNewNote()
                saveCheckmark.isHidden = false
                //print("new note saved")
            }
        }
        else{
            //update saved note and display save checkmark
            DBHelperNotes.dbHelper.updateNoteData(title: noteTitle.text!, content: noteContent.text!)
            saveCheckmark.isHidden = false
            //print("note updated")
        }
    }
    
    @IBAction func deleteClicked(_ sender: Any) {
        if !newNoteStatus{
            deleteNote()
            deleteCheckmark.isHidden = false
        }
    }
    
    func getCurrentText(){
        if !newNoteStatus{
            let note = DBHelperNotes.dbHelper.getOneNoteData(title:  currentTitle)
            noteTitle.text = currentTitle
            noteContent.text = note.noteData.content!
        }
    }
    
}
