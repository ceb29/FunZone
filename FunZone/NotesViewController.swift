//
//  NotesViewController.swift
//  FunZone
//
//  Created by admin on 5/26/22.
//

import UIKit

class NotesViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    let userDefault = UserDefaults.standard
    var dataText : [String] = []
    
    @IBOutlet weak var notesCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNotes()
        dataText = userDefault.object(forKey: "notes") as! [String]
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        dataText = userDefault.object(forKey: "notes") as! [String]
        self.notesCollectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var total = dataText.count + 1
        return total
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let myCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! NoteCollectionViewCell
        switch indexPath.item{
        case 0:
            myCell.noteLabel.text = "New Note"
            myCell.backgroundColor = UIColor.gray
            myCell.layer.cornerRadius = 10
            myCell.layer.masksToBounds = true
            return myCell    
        default:
            myCell.noteLabel.text = dataText[indexPath.row - 1]
            myCell.backgroundColor = UIColor.gray
            myCell.layer.cornerRadius = 10
            myCell.layer.masksToBounds = true
            return myCell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.item{
        case 0:
            userDefault.set(-1, forKey: "noteId")
        default:
            userDefault.set(indexPath.row - 1, forKey: "noteId")
        }
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let newNoteScreen = storyBoard.instantiateViewController(withIdentifier: "NewNote")
        self.navigationController?.pushViewController(newNoteScreen, animated: true)
        print("test")
    }
    
    
    func setupNotes(){
        if userDefault.object(forKey: "notes") == nil{
            let notes : [String] = []
            userDefault.set(notes, forKey: "notes")
        }
    }
    
    
}
