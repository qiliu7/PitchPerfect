//
//  PlaySoundsViewController.swift
//  PitchPerfect
//
//  Created by Kappa on 2019/10/17.
//  Copyright © 2019 qi. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {
  
  // MARK: - Constants
  struct AudioPlaybackSetting {
    
    static let slowRate: Float = 0.5
    static let fastRate: Float = 1.5
    static let highPitch: Float = 1000
    static let lowPitch: Float = -1000
  }
  
  // MARK: - Outlets
  @IBOutlet weak var snailButton: UIButton!
  @IBOutlet weak var rabbitButton: UIButton!
  @IBOutlet weak var vaderButton: UIButton!
  @IBOutlet weak var chipmunkButton: UIButton!
  @IBOutlet weak var echoButton: UIButton!
  @IBOutlet weak var reverbButton: UIButton!
  @IBOutlet weak var stopButton: UIButton!
  
  var recordedAudioURL: URL!
  var audioFile: AVAudioFile!
  var audioEngine: AVAudioEngine!
  var audioPlayerNode: AVAudioPlayerNode!
  var stopTimer: Timer!
  
  enum ButtonType: Int {
    case slow = 0, fast, chipmunk, vader, echo, reverb
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupAudio()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    // set button image content mode to prevent stretching
    let playBackButtons = [snailButton, rabbitButton, vaderButton, chipmunkButton, echoButton, reverbButton]
    for button in playBackButtons {
      button?.setToFixAspectRatio()
    }
    configureUI(.notPlaying)
  }
  
  // MARK: - Actions
  @IBAction func playSoundForButton(_ sender: UIButton) {
    switch(ButtonType(rawValue: sender.tag)! ) {
    case .slow:
      playSound(rate: AudioPlaybackSetting.slowRate)
    case .fast:
      playSound(rate: AudioPlaybackSetting.fastRate)
    case .chipmunk:
      playSound(pitch: AudioPlaybackSetting.highPitch)
    case .vader:
      playSound(pitch: AudioPlaybackSetting.lowPitch)
    case .echo:
      playSound(echo: true)
    case .reverb:
      playSound(reverb: true)
    }
    configureUI(.playing)
  }
  
  @IBAction func stopButtonPressed(_ sender: UIButton) {
    stopAudio()
  }
}

extension UIButton {
  func setToFixAspectRatio() {
    self.imageView?.contentMode = .scaleAspectFit
  }
}


