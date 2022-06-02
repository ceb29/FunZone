//
//  MusicViewController.swift
//  FunZone
//
//  Created by admin on 5/26/22.
//

import UIKit

class MusicViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    @IBOutlet weak var musicTableView: UITableView!
    var dataText = ["bensound-afterlight", "bensound-allthewayup", "bensound-autoreverse", "bensound-awaken", "bensound-brave", "bensound-dontforget", "bensound-dontlookbehind", "bensound-floating", "bensound-funkhouse", "bensound-gravity", "bensound-lifeiswonderful", "bensound-longroad", "bensound-takingcare", "bensound-wonderfulworld", "bensound-worldonfire"]
    var searchResultDataText : [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchResultDataText = dataText
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResultDataText.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let myCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MusicTableViewCell
        myCell.musicLabel.text = searchResultDataText[indexPath.row]
        //myCell.backgroundColor = UIColor.clear
        return myCell
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty{
            searchResultDataText = dataText
        }
        else{
            searchResultDataText = dataText.filter {(str : String) -> Bool in return str.lowercased().contains(searchText.lowercased())}
        }
        musicTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyObject = UIStoryboard(name: "Main", bundle: nil)
        let musicPlayerScreen = storyObject.instantiateViewController(withIdentifier: "MusicPlayer") as! MusicPlayerViewController
        musicPlayerScreen.currentSong = searchResultDataText[indexPath.item]
        self.navigationController?.pushViewController(musicPlayerScreen, animated: true)
    }
}
