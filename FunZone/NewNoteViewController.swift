//
//  NewNoteViewController.swift
//  FunZone
//
//  Created by admin on 5/28/22.
//

import UIKit

class NewNoteViewController: UIViewController {
    
    @IBOutlet weak var note: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func saveClicked(_ sender: Any) {
        var notes = userDefault.object(forKey: "notes") as? [String]
        notes?.append(note.text)
        userDefault.set(notes, forKey: "colorKey")
    }

}
