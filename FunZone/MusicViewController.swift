//
//  MusicViewController.swift
//  FunZone
//
//  Created by admin on 5/26/22.
//

import UIKit

class MusicViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    @IBOutlet weak var musicTableView: UITableView!
    static var dataText = ["bensound-afterlight", "bensound-allthewayup", "bensound-autoreverse", "bensound-awaken", "bensound-brave", "bensound-dontforget", "bensound-dontlookbehind", "bensound-floating", "bensound-funkhouse", "bensound-gravity", "bensound-lifeiswonderful", "bensound-longroad", "bensound-takingcare", "bensound-wonderfulworld", "bensound-worldonfire"]
    static var dataImg : [String : String] = ["bensound-afterlight" : "andybirdArtwork", "bensound-allthewayup" : "edrecords" , "bensound-autoreverse" : "twinsmusic-retro", "bensound-awaken" : "danphillipson", "bensound-brave" : "twinsmusic-cinematic", "bensound-dontforget" : "yari", "bensound-dontlookbehind": "evertzeevalkink", "bensound-floating" : "tomasnovoa", "bensound-funkhouse" : "indiebox-3", "bensound-gravity" : "andybirdArtwork", "bensound-lifeiswonderful" : "zacnelson" , "bensound-longroad" : "evertzeevalkink", "bensound-takingcare" : "indiebox-3", "bensound-wonderfulworld" : "indiebox-3", "bensound-worldonfire" : "andybirdArtwork"]
    var searchResultDataText : [String] = []
    
    var searchResultDataIndex : [Int] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchResultDataText = MusicViewController.dataText
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResultDataText.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let myCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MusicTableViewCell
        myCell.musicLabel.text = searchResultDataText[indexPath.row]
        myCell.musicImg.image = UIImage(named: MusicViewController.dataImg[searchResultDataText[indexPath.row]]!)
        //myCell.backgroundColor = UIColor.clear
        return myCell
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty{
            searchResultDataText = MusicViewController.dataText
        }
        else{
            searchResultDataText = MusicViewController.dataText.filter {(str : String) -> Bool in return str.lowercased().contains(searchText.lowercased())}
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
