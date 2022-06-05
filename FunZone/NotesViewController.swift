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
    var dataText : [String] = []
    var searchResultDataText : [String] = []
    var searchResultsIndex : [Int] = []
    var searchActive = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataText = getTitles() //load the saved note files
        searchResultDataText = dataText //initial search results should hold all dataText
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //if back was pressed on new note screen reload
        super.viewWillAppear(true)
        dataText = getTitles()
        searchActive = false
        searchResultDataText = dataText
        notesSearchBar.text = ""
        self.notesCollectionView.reloadData()
    }
    
    func getTitles() -> [String]{
        //get saved note title data
        var titles : [String] = []
        let notesData = DBHelperNotes.dbHelper.getNoteData()
        for data in notesData{
            titles.append(data.title!)
        }
        return titles
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let total = searchResultDataText.count + 1 //add one item for adding new notes
        return total
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //setup and display collection view items
        let myCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! NoteCollectionViewCell
        switch indexPath.item{
        case 0: //first item should be for adding new notes
            myCell.noteLabel.text = "New Note\n+"
            myCell.backgroundColor = UIColor.systemGray
            myCell.noteLabel.textColor = UIColor.white
            myCell.layer.cornerRadius = 10
            myCell.layer.masksToBounds = true
            return myCell    
        default: //all other items are for saved notes
            myCell.noteLabel.text = searchResultDataText[indexPath.row - 1]
            myCell.backgroundColor = UIColor.white
            myCell.noteLabel.textColor = UIColor.black
            myCell.layer.cornerRadius = 10
            myCell.layer.masksToBounds = true
            return myCell
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        //if search text is empty search results should hold all dataText
        //else filter and add update search results
        //then update collection view to show current search results
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
        //setup new note screen object and load new screen
        var newNoteStatus = true
        var titleToPass = ""
        switch indexPath.item{
        case 0: //if new note item was pressed new note status is set true
            newNoteStatus = true
            //print(0)
        default: //if saved note was pressed new note status is set false and pass current title
            newNoteStatus = false
            titleToPass = searchResultDataText[indexPath.row - 1]
            //print(1)
        }
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let newNoteScreen = storyBoard.instantiateViewController(withIdentifier: "NewNote") as! NewNoteViewController
        newNoteScreen.newNoteStatus = newNoteStatus
        newNoteScreen.currentTitle = titleToPass
        self.navigationController?.pushViewController(newNoteScreen, animated: true)
       //print("item selected")
    }
    
}
