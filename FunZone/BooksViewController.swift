//
//  BooksViewController.swift
//  FunZone
//
//  Created by admin on 5/26/22.
//

import UIKit

class BooksViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource{
    var dataText = ["song1", "song2", "song3", "song4", "song5", "song6", "song7", "song8", "song9", "song10", "song11", "song12"]
    //var dataImg = ["img1", "img1", "img1", "img1", "img1", "img1", "img1", "img1", "img1", "img1", "img1", "img1"]
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let myCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell1", for: indexPath) as! BooksCollectionViewCell
        myCell.bookLabel.text = dataText[indexPath.row]
        //myCell.bookImg.image = UIImage(named: dataImg[indexPath.row])
        myCell.backgroundColor = UIColor.gray
        myCell.layer.cornerRadius = 10
        myCell.layer.masksToBounds = true
        return myCell
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}
