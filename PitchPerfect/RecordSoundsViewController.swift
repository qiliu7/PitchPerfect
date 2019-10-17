//
//  RecordSoundsViewController.swift
//  PitchPerfect
//
//  Created by Kappa on 2019/10/14.
//  Copyright © 2019 qi. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {
  
  let stopRecordingSegueID = "stopRecording"
  var audioRecorder: AVAudioRecorder!
  
  @IBOutlet weak var recordingLabel: UILabel!
  @IBOutlet weak var recordButton: UIButton!
  @IBOutlet weak var stopRecordingButton: UIButton!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    stopRecordingButton.isEnabled = false
    // Do any additional setup after loading the view.
  }


  @IBAction func recordAudio(_ sender: Any) {
    recordingLabel.text = "Recording in Progress"
    stopRecordingButton.isEnabled = true
    recordButton.isEnabled = false
    
    let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
    let recordingName = "recordedVoice.wav"
    let pathArray = [dirPath, recordingName]
    let filePath = URL(fileURLWithPath: pathArray.joined(separator: "/"))
    print(filePath)
    
    let session = AVAudioSession.sharedInstance()
    try! session.setCategory(.playAndRecord, mode: .default, options:.defaultToSpeaker)
    
    try! audioRecorder = AVAudioRecorder(url: filePath, settings: [:])
    audioRecorder.delegate = self
    audioRecorder.isMeteringEnabled = true
    audioRecorder.prepareToRecord()
    audioRecorder.record()
  }
  
  @IBAction func stopRecording(_ sender: Any) {
    recordingLabel.text = "Tap to Record"
    recordButton.isEnabled = true
    stopRecordingButton.isEnabled = false
    
    audioRecorder.stop()
    let audioSession = AVAudioSession.sharedInstance()
    try! audioSession.setActive(false)
  }
  
  func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
    if flag {
      performSegue(withIdentifier: "stopRecording", sender: audioRecorder.url)
      
    } else {
     print("recording was not successful")
    }
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == stopRecordingSegueID {
      let playSoundsVC = segue.destination as! PlaySoundsViewController
      let recordedAudioURL = sender as! URL
      playSoundsVC.recordedAudioURL = recordedAudioURL
    }
  }
}

