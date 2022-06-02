//
//  MusicViewController.swift
//  FunZone
//
//  Created by admin on 5/26/22.
//

import UIKit
import AVFoundation

class MusicViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    @IBOutlet weak var musicTableView: UITableView!
    @IBOutlet weak var songTitleLabel: UILabel!
    var musicPlayer : AVAudioPlayer?
    var musicFile : String?
    var currentSong = ""
    var dataText = ["bensound-afterlight", "bensound-allthewayup", "bensound-autoreverse", "bensound-awaken", "bensound-brave", "bensound-dontforget", "bensound-dontlookbehind", "bensound-floating", "bensound-funkhouse", "bensound-gravity", "bensound-lifeiswonderful", "bensound-longroad", "bensound-takingcare", "bensound-wonderfulworld", "bensound-worldonfire"]
    var searchResultDataText : [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMusicPlayer()
        searchResultDataText = dataText
    }
    
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
            searchResultDataText = dataText.filter {(str : String) -> Bool in return str.lowercased().contains(searchText.lowercased())}
        }
        musicTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        currentSong = searchResultDataText[indexPath.item]
        songTitleLabel.text = currentSong
    }
    
    func setupMusicPlayer(){
        let filePath = Bundle.main.path(forResource: currentSong, ofType: "mp3")
        let url = URL(fileURLWithPath: filePath!)
        do{
            musicPlayer = try AVAudioPlayer(contentsOf: url)
        }
        catch{
            print("file not found")
        }
    }
    
    @IBAction func playMusic(_ sender: Any) {
        musicPlayer?.play()
        print("music is playing")
    }
    
    @IBAction func stopMusic(_ sender: Any) {
        musicPlayer?.stop()
        print("music stopped playing")
    }
    
}
