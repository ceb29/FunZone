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
    var timer : Timer?
    var x : Float = 0
    var songDuration = ""
    var playing = false
    var songLoaded = false
    var currentSongIndex = 0
    var dataTextSize = MusicViewController.dataText.count
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var progressSlider: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        songTitleLabel.text = currentSong
        setupMusicPlayer()
        getCurrentSongIndex()
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
    
    func getFormatedTime(seconds : Int) -> String{
        let minutes = seconds / 60
        let secondsRemaining = seconds % 60
        if secondsRemaining < 10{
            return String(minutes) + ":0" + String(secondsRemaining)
        }
        return String(minutes) + ":" + String(secondsRemaining)
    }
    
    func getCurrentSongIndex(){
        for i in 0..<dataTextSize - 1{
            if currentSong == MusicViewController.dataText[i]{
                currentSongIndex = i
                break
            }
        }
    }
    
    func stopPlaying(){
        musicPlayer?.stop()
        musicPlayer?.currentTime = 0
        timer?.invalidate()
        x = 0
        resultLabel.text = "0:00"
        progressSlider.value = 0
        playing = false
        print("music stopped playing")
    }
    
    func startPlaying(){
        musicPlayer?.play()
        songLoaded = true
        durationLabel.text = getFormatedTime(seconds: Int(musicPlayer!.duration))
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateMusicTime), userInfo: nil, repeats: true)
        playing = true
        print("music is playing")
    }
    
    @IBAction func playPauseClicked(_ sender: Any) {
        if playing{
            musicPlayer?.pause()
            timer?.invalidate()
            playing = false
            print("music is paused")
        }
        else{
            startPlaying()
        }
    }
    
    @IBAction func stopClicked(_ sender: Any) {
        musicPlayer?.stop()
        musicPlayer?.currentTime = 0
        timer?.invalidate()
        x = 0
        resultLabel.text = "0:00"
        progressSlider.value = 0
        playing = false
        print("music stopped playing")
    }
    
    @IBAction func progressSliderMoved(_ sender: Any) {
        if songLoaded{
            //musicPlayer?.currentTime = progressSlider.value * Float(musicPlayer!.duration)
            //resultLabel.text = getFormatedTime(Int(musicPlayer!.currentTime))
            x = progressSlider.value * Float(musicPlayer!.duration)
            resultLabel.text = getFormatedTime(seconds: Int(x))
        }
        else{
            progressSlider.value = 0
        }
    }
    
    func updateSong(){
        currentSong = MusicViewController.dataText[currentSongIndex]
        songTitleLabel.text = currentSong
        if playing{
            stopPlaying()
            startPlaying()
        }
        else{
            stopPlaying()
        }
    }
    
    @IBAction func goToNextSong(_ sender: Any) {
        switch currentSongIndex{
        case dataTextSize - 1:
            currentSongIndex = 0
        default:
            currentSongIndex+=1
        }
        updateSong()
    }
    
    @IBAction func goToPreviousSong(_ sender: Any) {
        switch currentSongIndex{
        case 0:
            currentSongIndex = dataTextSize - 1
        default:
            currentSongIndex-=1
        }
        updateSong()
    }
    
    @objc func updateMusicTime(){
        //resultLabel.text = getFormatedTime(Int(musicPlayer!.currentTime))
        //progressSlider.value = Float(musicPlayer!.currentTime) / Float(musicPlayer!.duration)
        print("current time description: ", musicPlayer?.currentTime.description)
        
        x+=1
        resultLabel.text = getFormatedTime(seconds: Int(x))
        progressSlider.value = x / Float(musicPlayer!.duration)
    }
}
