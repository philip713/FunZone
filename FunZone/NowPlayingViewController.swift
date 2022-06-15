//
//  NowPlayingViewController.swift
//  FunZone
//
//  Created by Philip Janzel Paradeza on 2022-06-02.
//

import UIKit
import AVFoundation

class NowPlayingViewController: UIViewController, AVAudioPlayerDelegate{
    
    static var audioPlayer : AVAudioPlayer?
    var player : AVPlayer?
    var musicFile : String?
    var songList : [String]?
    var songIndex : Int?
    var timer : Timer?
    @IBOutlet weak var songTitleLabel: UILabel!
    @IBOutlet weak var currentTimeLabel: UILabel!
    @IBOutlet weak var fullTimeLabel: UILabel!
    @IBOutlet weak var songSeeker: UISlider!
    
    struct TimeParts: CustomStringConvertible {
        var seconds = 0
        var minutes = 0
        /// The string representation of the time parts (ex: 07:37)
        var description: String {
            return NSString(format: "%02d:%02d", minutes, seconds) as String
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        playSong()
        
    }
    
    @IBAction func previousButtonClick(_ sender: Any) {
        previousSong()
    }
    @IBAction func backButtonClick(_ sender: Any) {
        
        NowPlayingViewController.audioPlayer?.currentTime -= 10
    }
    @IBAction func playPauseButtonClick(_ sender: Any) {
        
        if(NowPlayingViewController.audioPlayer!.isPlaying){
            NowPlayingViewController.audioPlayer?.pause()
        }
        else{
            NowPlayingViewController.audioPlayer?.play()
        }
    }
    @IBAction func forwardButtonClick(_ sender: Any) {
        NowPlayingViewController.audioPlayer?.currentTime += 10
    }
    @IBAction func nextButtonClick(_ sender: Any) {
        nextSong()
    }
    @IBAction func songSeekerDragged(_ sender: Any) {
        let newCurrentTime = Int(songSeeker.value) * Int(NowPlayingViewController.audioPlayer!.duration)
        NowPlayingViewController.audioPlayer?.currentTime = Double(songSeeker.value) * NowPlayingViewController.audioPlayer!.duration
        currentTimeLabel.text = toTimeParts(newCurrentTime)
    }
    
    
    func playSong()
    {
        musicFile = songList![songIndex!]
        let filePath = Bundle.main.path(forResource: musicFile, ofType: "mp3")
        let newURL = URL(fileURLWithPath: filePath!)
        do{
            NowPlayingViewController.audioPlayer =  try AVAudioPlayer(contentsOf: newURL)
            NowPlayingViewController.audioPlayer?.delegate = self
        }
        catch{
            print("file not found")
        }
        NowPlayingViewController.audioPlayer?.play()
        songTitleLabel.text = musicFile
        fullTimeLabel.text = toTimeParts(Int(NowPlayingViewController.audioPlayer!.duration))
        updateCurrentTime()
        
    }
    
    func previousSong(){
        if(songIndex == 0){
            songIndex = songList!.count - 1
        }
        else{
            
            songIndex! -= 1
        }
        
        playSong()
    }
    
    func nextSong(){
        if(songIndex == songList!.count - 1){
            songIndex = 0
        }
        else{
            
            songIndex! += 1
        }
        
        playSong()
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        nextSong()
    }
    
    //These two functions are for the current time label and the seeker
    func updateCurrentTime(){
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
    }
    @objc func updateTime(){
        if(NowPlayingViewController.audioPlayer!.currentTime >= NowPlayingViewController.audioPlayer!.duration){
            nextSong()
        }
        currentTimeLabel.text = toTimeParts(Int(NowPlayingViewController.audioPlayer!.currentTime))
        songSeeker.value = Float(NowPlayingViewController.audioPlayer!.currentTime)/Float(NowPlayingViewController.audioPlayer!.duration)
    }
    
    //convert time to mm:ss format
    func toTimeParts(_ num : Int) -> String {
            let seconds = num
            var mins = 0
            var secs = seconds
            if seconds >= 60 {
                mins = Int(seconds / 60)
                secs = seconds - (mins * 60)
            }
        return TimeParts(seconds: secs, minutes: mins).description
        }
}
