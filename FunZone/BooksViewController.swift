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
    //var dataImg = ["img1", "img1", "img1", "img1", "img1", "img1", "img1", "img1", "img1", "img1", "img1", "img1", "img1", "img1", "img1"]
    var searchResultDataText : [String] = []
    var searchResultDataImg : [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchResultDataText = dataText
        //searchResultDataImg = dataImg
        
        // Do any additional setup after loading the view.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchResultDataText.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let myCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! BooksCollectionViewCell
        myCell.bookLabel.text = searchResultDataText[indexPath.row]
        //myCell.bookImg.image = UIImage(named: dataImg[indexPath.row])
        myCell.backgroundColor = UIColor.gray
        myCell.layer.cornerRadius = 10
        myCell.layer.masksToBounds = true
        return myCell
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty{
            searchResultDataText = dataText
        }
        else{
            searchResultDataText = dataText.filter {(str : String) -> Bool in return str.lowercased().contains(searchText.lowercased())}
        }
        booksCollectionView.reloadData()
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyObject = UIStoryboard(name: "Main", bundle: nil)
        let bookScreenVc = storyObject.instantiateViewController(withIdentifier: "BookViewer") as! OpenedBookViewController
        bookScreenVc.pdfname = searchResultDataText[indexPath.item]
        self.navigationController?.pushViewController(bookScreenVc, animated: true)
    }

}
