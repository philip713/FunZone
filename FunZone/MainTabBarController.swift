//
//  MainTabBarController.swift
//  FunZone
//
//  Created by Philip Janzel Paradeza on 2022-06-06.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

    
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        if(NowPlayingViewController.audioPlayer != nil){
            NowPlayingViewController.audioPlayer?.stop()
        }
    }
}
