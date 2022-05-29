//
//  MusicViewController.swift
//  FunZone
//
//  Created by admin on 5/26/22.
//

import UIKit

class MusicViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    @IBOutlet weak var musicTableView: UITableView!
    var dataText = ["song1", "song2", "song3", "song4", "song5", "song6", "song7", "song8", "song9", "song10", "song11", "song12", "song13", "song14", "song15"]
    var searchResultDataText : [String] = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResultDataText.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let myCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MusicTableViewCell
        myCell.musicLabel.text = searchResultDataText[indexPath.row]
        return myCell
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty{
            searchResultDataText = dataText
        }
        else{
            searchResultDataText = dataText.filter {(str : String) -> Bool in return str.contains(searchText.lowercased())}
        }
        musicTableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchResultDataText = dataText

        // Do any additional setup after loading the view.
    }

}
