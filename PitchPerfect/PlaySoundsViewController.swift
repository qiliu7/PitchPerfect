//
//  PlaySoundsViewController.swift
//  PitchPerfect
//
//  Created by Kappa on 2019/10/17.
//  Copyright © 2019 qi. All rights reserved.
//

import UIKit

class PlaySoundsViewController: UIViewController {
  
  @IBOutlet weak var slowButton: UIButton!
  
  var recordedAudioURL: URL! {
    didSet {
      if let url = recordedAudioURL{
        print("received URL: \(url)")
      }
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
  }
  
  
  /*
   // MARK: - Navigation
   
   // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
   // Get the new view controller using segue.destination.
   // Pass the selected object to the new view controller.
   }
   */
  
}


