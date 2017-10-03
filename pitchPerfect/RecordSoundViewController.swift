//
//  RecordSoundViewController.swift
//  pitchPerfect
//
//  Created by Rishabh on 11/04/1939 Saka.
//  Copyright © 1939 Saka rishi. All rights reserved.
//

import UIKit
import AVFoundation


class RecordSoundViewController: UIViewController,AVAudioRecorderDelegate {
    var audioRecorder:AVAudioRecorder!
    
    
    
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var recordingLabel: UILabel!
    @IBOutlet weak var stopRecordingButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        stopRecordingButton.isEnabled = false
    }
    
    
    func uiConfigure( recording:Bool){
        
        
       
        recordingLabel.text = recording ? "Recording in progress": "Tap To Record"
        recordButton.isEnabled = recording ? false : true
        stopRecordingButton.isEnabled = recording ? true : false
       
    }
    
    @IBAction func recordAudio(_ sender: Any) {
        
        uiConfigure(recording: true)
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)[0] as String
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = URL(string: pathArray.joined(separator: "/"))
        
        
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord, with:AVAudioSessionCategoryOptions.defaultToSpeaker)
        
        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
        audioRecorder.delegate = self
    }
    
    
    @IBAction func recordStop(_ sender: Any) {
        
        uiConfigure(recording: false)
        
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        
        if flag{
            performSegue(withIdentifier: "stopRecording", sender: audioRecorder.url)
        }
        else{
            print("recording was not successful")
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "stopRecording"{
            let playSoundVC = segue.destination as! PlaySoundsViewController
            let recordedAudioURL = sender as! URL
            playSoundVC.recordedAudioURL = recordedAudioURL
        }
        
    }
}
