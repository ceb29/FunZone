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
    var currentSongImg = ""
    var timer : Timer?
    var simulatedTime : Float = 0
    var songDuration = ""
    var playing = false
    var songLoaded = false
    var currentSongIndex = 0
    var dataTextSize = MusicViewController.dataText.count
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var progressSlider: UISlider!
    @IBOutlet weak var songImg: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        songTitleLabel.text = currentSong
        songImg.image = UIImage(named: currentSongImg)
        setupMusicPlayer()
        getCurrentSongIndex()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        stopPlaying()
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
        if playing{
            musicPlayer?.stop()
            musicPlayer?.currentTime = 0
            timer?.invalidate()
            simulatedTime = 0
            resultLabel.text = "0:00"
            progressSlider.value = 0
            playing = false
            print("music stopped playing")
        }
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
        if playing{
            stopPlaying()
        }
    }
    
    @IBAction func progressSliderMoved(_ sender: Any) {
        if songLoaded{
            //musicPlayer?.currentTime = progressSlider.value * Float(musicPlayer!.duration)
            //resultLabel.text = getFormatedTime(Int(musicPlayer!.currentTime))
            simulatedTime = progressSlider.value * Float(musicPlayer!.duration)
            resultLabel.text = getFormatedTime(seconds: Int(simulatedTime))
        }
        else{
            progressSlider.value = 0
        }
    }
    
    func updateSong(){
        currentSong = MusicViewController.dataText[currentSongIndex]
        currentSongImg = MusicViewController.dataImg[currentSong]!
        songTitleLabel.text = currentSong
        songImg.image = UIImage(named: currentSongImg)
        
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
        print("musicPlayer!.currenttime.description: ", musicPlayer?.currentTime.description, "simulatedTime: ", simulatedTime)
        simulatedTime+=1
        resultLabel.text = getFormatedTime(seconds: Int(simulatedTime))
        progressSlider.value = simulatedTime / Float(musicPlayer!.duration)
    }
}
