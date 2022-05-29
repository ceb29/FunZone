//
//  BooksViewController.swift
//  FunZone
//
//  Created by admin on 5/26/22.
//

import UIKit

class BooksViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UISearchBarDelegate{
    @IBOutlet weak var booksCollectionView: UICollectionView!
    var dataText = ["book1", "book2", "book3", "book4", "book5", "book6", "book7", "book8", "book9", "book10", "book11", "book12", "book13", "book14", "book15"]
    var dataImg = ["img1", "img1", "img1", "img1", "img1", "img1", "img1", "img1", "img1", "img1", "img1", "img1", "img1", "img1", "img1"]
    var SearchResultDataText : [String] = []
    var SearchResultDataImg : [String] = []
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return SearchResultDataText.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let myCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! BooksCollectionViewCell
        myCell.bookLabel.text = SearchResultDataText[indexPath.row]
        //myCell.bookImg.image = UIImage(named: dataImg[indexPath.row])
        myCell.backgroundColor = UIColor.gray
        myCell.layer.cornerRadius = 10
        myCell.layer.masksToBounds = true
        return myCell
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty{
            SearchResultDataText = dataText
        }
        else{
            SearchResultDataText = dataText.filter {(str : String) -> Bool in return str.contains(searchText.lowercased())}
        }
        booksCollectionView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        SearchResultDataText = dataText
        SearchResultDataImg = dataImg
        
        // Do any additional setup after loading the view.
    }

}
