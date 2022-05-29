//
//  NewNoteViewController.swift
//  FunZone
//
//  Created by admin on 5/28/22.
//

import UIKit

class NewNoteViewController: UIViewController {
    let userDefault = UserDefaults.standard
    @IBOutlet weak var note: UITextView!
    var dataText : [String] = []
    var currentNoteId = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        note.layer.cornerRadius = 10
        note.layer.masksToBounds = true
        getCurrentText()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        getCurrentText()
    }
    
    @IBAction func saveClicked(_ sender: Any) {
        if(currentNoteId == -1){
            dataText.append(note.text)
            currentNoteId = dataText.count - 1 //create new note and save into new notes id
        }
        else{
            dataText[currentNoteId] = note.text
        }
        
        userDefault.set(dataText, forKey: "notes")
    }
    
    @IBAction func deleteClicked(_ sender: Any) {
        if currentNoteId != -1{
            dataText.remove(at: currentNoteId)
            userDefault.set(dataText, forKey: "notes")
            currentNoteId = -1
        }
    }
    
    func getCurrentText(){
        currentNoteId = userDefault.integer(forKey: "noteId")
        dataText = userDefault.object(forKey: "notes") as! [String]
        if (currentNoteId != -1){
            note.text = String(dataText[currentNoteId])
        }
    }
    
    
    
}
