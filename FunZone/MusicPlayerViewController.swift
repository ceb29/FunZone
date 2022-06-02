//
//  MusicPlayerViewController.swift
//  FunZone
//
//  Created by admin on 6/1/22.
//

import UIKit
import AVFoundation

class MusicPlayerViewController: UIViewController {
    @IBOutlet weak var songTitleLabel: UILabel!
    var musicPlayer : AVAudioPlayer?
    var currentSong = ""
    var playing = false
    override func viewDidLoad() {
        super.viewDidLoad()
        songTitleLabel.text = currentSong
        setupMusicPlayer()
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
    
    @IBAction func playPauseClicked(_ sender: Any) {
        if playing{
            musicPlayer?.pause()
            print("music is paused")
        }
        else{
            musicPlayer?.play()
            playing = true
            print("music is playing")
        }
    }
    
    @IBAction func stopClicked(_ sender: Any) {
        musicPlayer?.stop()
        print("music stopped playing")
    }
    
}
