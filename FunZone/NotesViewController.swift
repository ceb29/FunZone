//
//  NotesViewController.swift
//  FunZone
//
//  Created by admin on 5/26/22.
//

import UIKit

class NotesViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    var dataText : [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNotes()
        dataText = userDefault.object(forKey: "notes") as! [String]
        // Do any additional setup after loading the view.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section{
        case 0:
            return 1
        case 1:
            return dataText.count
        default:
            return 1
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let myCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! NoteCollectionViewCell
        switch indexPath.section{
        case 0:
            myCell.noteLabel.text = "New Note"
            myCell.backgroundColor = UIColor.gray
            myCell.layer.cornerRadius = 10
            myCell.layer.masksToBounds = true
            return myCell
        case 1:
            myCell.noteLabel.text = dataText[indexPath.row]
            myCell.backgroundColor = UIColor.gray
            myCell.layer.cornerRadius = 10
            myCell.layer.masksToBounds = true
            return myCell
        default:
            return myCell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("test")
    }
    
    
    func setupNotes(){
        if userDefault.object(forKey: "notes") == nil{
            var notes : [String] = []
            userDefault.set(notes, forKey: "notes")
        }
    }
}
