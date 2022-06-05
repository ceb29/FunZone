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
    var currentStatus = SongStatus.stopped
    var songLoaded = false
    var currentSongIndex = 0
    var dataTextSize = MusicViewController.dataText.count
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var progressSlider: UISlider!
    @IBOutlet weak var songImg: UIImageView!
    
    enum SongStatus {
        case playing
        case stopped
        case paused
    }
    
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
        switch currentStatus {
        case .stopped:
            //print("music already stopped")
            break //do nothing
        default:
            musicPlayer?.stop()
            musicPlayer?.currentTime = 0
            timer?.invalidate()
            simulatedTime = 0
            resultLabel.text = "0:00"
            progressSlider.value = 0
            currentStatus = .stopped
            print("music stopped playing")
        }
    }
    
    func startPlaying(){
        musicPlayer?.play()
        songLoaded = true
        durationLabel.text = getFormatedTime(seconds: Int(musicPlayer!.duration))
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateMusicTime), userInfo: nil, repeats: true)
        currentStatus = .playing
        print("music is playing")
    }
    
    func updateSong(){
        currentSong = MusicViewController.dataText[currentSongIndex]
        currentSongImg = MusicViewController.dataImg[currentSong]!
        songTitleLabel.text = currentSong
        songImg.image = UIImage(named: currentSongImg)
        
        switch currentStatus {
        case .playing:
            stopPlaying()
            startPlaying()
        default:
            stopPlaying()
        }
    }
    
    @IBAction func playPauseClicked(_ sender: Any) {
        switch currentStatus {
        case .playing:
            musicPlayer?.pause()
            timer?.invalidate()
            currentStatus = .paused
            print("music is paused")
        default:
            startPlaying()
        }
    }
    
    @IBAction func stopClicked(_ sender: Any) {
        switch currentStatus {
        case .stopped:
            print("music already stopped")
        default:
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
        simulatedTime+=1
        resultLabel.text = getFormatedTime(seconds: Int(simulatedTime))
        progressSlider.value = simulatedTime / Float(musicPlayer!.duration)
        print("musicPlayer!.currenttime.description: ", musicPlayer?.currentTime.description, "simulatedTime: ", simulatedTime)
    }
}
