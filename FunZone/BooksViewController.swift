//
//  BooksViewController.swift
//  FunZone
//
//  Created by admin on 5/26/22.
//

import UIKit

class BooksViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UISearchBarDelegate{
    @IBOutlet weak var booksCollectionView: UICollectionView!
    var dataText = ["Basic Operators", "Closures", "Collection Types", "Control Flow", "Enumerations", "Error Handling", "Extensions", "Functions", "Inheritance", "Initialization", "Methods", "Nested Types", "Optional Chaining", "Properties", "Structures and Classes"]
    var searchResultDataText : [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchResultDataText = dataText //initial search result should hold all data
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchResultDataText.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //setup cell text and images
        let myCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! BooksCollectionViewCell
        myCell.bookLabel.text = searchResultDataText[indexPath.row]
        myCell.bookImg.image = UIImage(named: searchResultDataText[indexPath.row])
        myCell.backgroundColor = UIColor.white
        myCell.layer.cornerRadius = 10 //make the cell edges curved
        myCell.layer.masksToBounds = true
        return myCell
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty{ //if search is empty, search results should hold all data
            searchResultDataText = dataText
        }
        else{ //filter data using search text and store in search results
            searchResultDataText = dataText.filter {(str : String) -> Bool in return str.lowercased().contains(searchText.lowercased())}
        }
        booksCollectionView.reloadData() //reload collection view to show updated result
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //setup next screen object and go to next screen
        let storyObject = UIStoryboard(name: "Main", bundle: nil)
        let bookScreenVc = storyObject.instantiateViewController(withIdentifier: "BookViewer") as! OpenedBookViewController
        bookScreenVc.pdfname = searchResultDataText[indexPath.item]
        self.navigationController?.pushViewController(bookScreenVc, animated: true)
    }

}
