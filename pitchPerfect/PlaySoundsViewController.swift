//
//  PlaySoundsViewController.swift
//  pitchPerfect
//
//  Created by Rishabh on 12/04/1939 Saka.
//  Copyright © 1939 Saka rishi. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {
    @IBOutlet weak var chipmunkButton: UIButton!
    @IBOutlet weak var snailButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var reverbButton: UIButton!
    @IBOutlet weak var echoButton: UIButton!
    @IBOutlet weak var vaberButton: UIButton!
    @IBOutlet weak var rabbitButton: UIButton!
    
    
    var recordedAudioURL:URL!
    
    
    var audioFile:AVAudioFile!
    var audioEngine:AVAudioEngine!
    var audioPlayerNode: AVAudioPlayerNode!
    var stopTimer: Timer!
    
    enum ButtonType: Int {
        case slow = 0, fast, chipmunk, vader, echo, reverb
    }
    
    
    @IBAction func playSoundForButton(_ sender: UIButton) {
        
        switch(ButtonType(rawValue: sender.tag)!) {
        case .slow:
            playSound(rate: 0.5)
        case .fast:
            playSound(rate: 1.5)
        case .chipmunk:
            playSound(pitch: 1000)
        case .vader:
            playSound(pitch: -1000)
        case .echo:
            playSound(echo: true)
        case .reverb:
            playSound(reverb: true)
        }
        
        configureUI(.playing)
        
    }
    
    @IBAction func stopButtonPressed(_ sender: AnyObject) {
        
        stopAudio()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAudio()
        
      chipmunkButton.imageView?.contentMode = .scaleAspectFit
        snailButton.imageView?.contentMode = .scaleAspectFit
        stopButton.imageView?.contentMode = .scaleAspectFit
        reverbButton.imageView?.contentMode = .scaleAspectFit
        echoButton.imageView?.contentMode = .scaleAspectFit
        rabbitButton.imageView?.contentMode = .scaleAspectFit
        vaberButton.imageView?.contentMode = .scaleAspectFit
        // Do any additional setup after loading the view.
    }
    

}
