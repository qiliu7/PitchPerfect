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
    
    // set buttons' image content mode to prevent from stretching
    let playBackButtons = [snailButton, rabbitButton, vaderButton, chipmunkButton, echoButton, reverbButton]
    for button in playBackButtons {
      button?.setToFixAspectRatio()
    }
    configureUI(.notPlaying)
  }
  
  // MARK: - Actions
  @IBAction func playSoundForButton(_ sender: UIButton) {
    print(" is pressed")
  }
  
  @IBAction func stopButtonPressed(_ sender: UIButton) {
    print("stop button is pressed")
  }

}

extension UIButton {
  
//  convenience init(imageContentMode: UIImageView.ContentMode = .scaleAspectFit) {
//    self.init()
//    self.imageView?.contentMode = imageContentMode
//  }
  
  func setToFixAspectRatio() {
    self.imageView?.contentMode = .scaleAspectFill
  }
}


