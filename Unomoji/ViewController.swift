//
//  ViewController.swift
//  Unomoji
//
//  Created by Dianne Katrina Bronola on 5/27/16.
//  Copyright © 2016 Dianne Bronola. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var audioPlayer: AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let introSound = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("intro", ofType: "aiff")!)
        
        audioPlayer = try!AVAudioPlayer(contentsOfURL: introSound)
        audioPlayer.prepareToPlay()
        audioPlayer.play()
        
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        audioPlayer.stop()
    }

}

