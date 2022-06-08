//
//  MusicViewController.swift
//  FunZone
//
//  Created by Philip Janzel Paradeza on 2022-06-02.
//

import UIKit

class MusicViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var songList = [""]
    
    @IBOutlet weak var musicViewHeader: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        musicViewHeader.text = LoginViewController.theUser! + " listens to island boy"
        songList = getSongs("/Users/philipjanzelparadeza/Desktop/FunZone/FunZone/Songs")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        songList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MusicTableViewCell
        cell.musicCellLabel.text = songList[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let songStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let songScreenVC = songStoryboard.instantiateViewController(withIdentifier: "NowPlaying") as! NowPlayingViewController
        songScreenVC.songList = songList
        songScreenVC.songIndex = indexPath.row
        self.present(songScreenVC, animated: true, completion: nil)
    }
    
    
    func getSongs(_ folderPath : String) -> [String]{
        let enumerator = FileManager.default.enumerator(atPath: folderPath)
        let filePaths = enumerator?.allObjects as! [String]
        var txtFilePaths = filePaths.filter{$0.contains(".mp3")}
        var i=0
        while(i < txtFilePaths.count)
        {
            txtFilePaths[i] = (txtFilePaths[i] as NSString).deletingPathExtension
            print(txtFilePaths[i])
            i += 1
        }
        return txtFilePaths
    }
    @IBAction func playPause_BtnClicked(_ sender: Any) {
        if(NowPlayingViewController.audioPlayer != nil){
        
            if(NowPlayingViewController.audioPlayer!.isPlaying){
                NowPlayingViewController.audioPlayer?.pause()
            }
            else{
                NowPlayingViewController.audioPlayer?.play()
            }
        }
    }
    @IBAction func back_BtnClicked(_ sender: Any) {
        if(NowPlayingViewController.audioPlayer != nil){
            NowPlayingViewController.audioPlayer?.currentTime -= 10
        }
    }
    
    @IBAction func forward_BtnClicked(_ sender: Any) {
        if(NowPlayingViewController.audioPlayer != nil){
            NowPlayingViewController.audioPlayer?.currentTime += 10
        }
    }
    
}
