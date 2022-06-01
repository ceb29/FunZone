//
//  NotesViewController.swift
//  FunZone
//
//  Created by admin on 5/26/22.
//

import UIKit

class NotesViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UISearchBarDelegate {
    @IBOutlet weak var notesCollectionView: UICollectionView!
    @IBOutlet weak var notesSearchBar: UISearchBar!
    let userDefault = UserDefaults.standard
    var dataText : [String] = []
    var searchResultDataText : [String] = []
    var searchResultsIndex : [Int] = []
    var searchActive = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataText = getTitles()
        searchResultDataText = dataText
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        dataText = getTitles()
        searchActive = false
        searchResultDataText = dataText
        notesSearchBar.text = ""
        self.notesCollectionView.reloadData()
    }
    
    func getTitles() -> [String]{
        var titles : [String] = []
        let notesData = DBHelperNotes.dbHelper.getNoteData()
        for data in notesData{
            titles.append(data.title!)
        }
        return titles
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let total = searchResultDataText.count + 1
        return total
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let myCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! NoteCollectionViewCell
        switch indexPath.item{
        case 0:
            myCell.noteLabel.text = "New Note\n+"
            myCell.backgroundColor = UIColor.systemGray
            myCell.noteLabel.textColor = UIColor.white
            myCell.layer.cornerRadius = 10
            myCell.layer.masksToBounds = true
            return myCell    
        default:
            myCell.noteLabel.text = searchResultDataText[indexPath.row - 1]
            myCell.backgroundColor = UIColor.white
            myCell.noteLabel.textColor = UIColor.black
            myCell.layer.cornerRadius = 10
            myCell.layer.masksToBounds = true
            return myCell
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty{
            searchActive = false
            print("search inactive")
            searchResultDataText = dataText
        }
        else{
            print("search active")
            searchActive = true
            //searchResultsIndex = dataText.indices.filter {(i : Int) -> Bool in return dataText[i].lowercased().contains(searchText.lowercased())}
            //print(searchResultsIndex)
            searchResultDataText = dataText.filter {(str : String) -> Bool in return str.lowercased().contains(searchText.lowercased())}
        }
        notesCollectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.item{
        case 0:
            userDefault.set(true, forKey: "newNote")
            //print(0)
        default:
            userDefault.set(false, forKey: "newNote")
            if searchActive{
                userDefault.set(searchResultDataText[indexPath.row - 1], forKey: "noteTitle")
            }
            else{
                userDefault.set(searchResultDataText[indexPath.row - 1], forKey: "noteTitle")
            }
            //print(1)
        }
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let newNoteScreen = storyBoard.instantiateViewController(withIdentifier: "NewNote")
        self.navigationController?.pushViewController(newNoteScreen, animated: true)
       //print("item selected")
    }
    
}
