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
  
  // MARK: Constants
  let stopRecordingSegueID = "stopRecording"
  let recordingError = "recording was not successful"
  
  var audioRecorder: AVAudioRecorder!
  var filePathURL: URL!
  
  // MARK: Outlets
  @IBOutlet weak var recordingLabel: UILabel!
  @IBOutlet weak var recordButton: UIButton!
  @IBOutlet weak var stopRecordingButton: UIButton!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    stopRecordingButton.isEnabled = false
  }

  // MARK: Actions
  @IBAction func recordAudio(_ sender: Any) {
    configureUI(isRecording: true)
    
    let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
    let recordingName = "recordedVoice.wav"
    let pathArray = [dirPath, recordingName]
    filePathURL = URL(fileURLWithPath: pathArray.joined(separator: "/"))
    
    let session = AVAudioSession.sharedInstance()
    try! session.setCategory(.playAndRecord, mode: .default, options:.defaultToSpeaker)
    
    try! audioRecorder = AVAudioRecorder(url: filePathURL, settings: [:])
    audioRecorder.delegate = self
    audioRecorder.isMeteringEnabled = true
    audioRecorder.prepareToRecord()
    audioRecorder.record()
  }
  
  @IBAction func stopRecording(_ sender: Any) {
    configureUI(isRecording: false)
    
    audioRecorder.stop()
    let audioSession = AVAudioSession.sharedInstance()
    try! audioSession.setActive(false)
  }
  
  // MARK: Audio Recorder Delegate
  func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
    if flag {
      performSegue(withIdentifier: stopRecordingSegueID, sender: self)
      
    } else {
     showAlert(recordingError, message: "")
    }
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == stopRecordingSegueID {
      let playSoundsVC = segue.destination as! PlaySoundsViewController
      playSoundsVC.recordedAudioURL = filePathURL
      
    }
  }
  
  func configureUI(isRecording: Bool) {
    recordingLabel.text = isRecording ? "Recording in Progress": "Tap to Record"
    stopRecordingButton.isEnabled = isRecording
    recordButton.isEnabled = !isRecording
  }
  
  func showAlert(_ title: String, message: String) {
      let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
      alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
      self.present(alert, animated: true, completion: nil)
  }
}

