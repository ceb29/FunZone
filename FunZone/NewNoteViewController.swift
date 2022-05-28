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
    var currentNoteId = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getCurrentText()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        getCurrentText()
    }
    
    @IBAction func saveClicked(_ sender: Any) {
        var notes = userDefault.object(forKey: "notes") as! [String]
        if(currentNoteId == -1){
            notes.append(note.text)
        }
        else{
            notes[currentNoteId] = note.text
        }
        
        userDefault.set(notes, forKey: "notes")
    }
    
    func getCurrentText(){
        currentNoteId = userDefault.integer(forKey: "noteId")
        if (currentNoteId != -1){
            let notes = userDefault.object(forKey: "notes") as! [String]
            note.text = String(notes[currentNoteId])
        }
        
    }
    
}
