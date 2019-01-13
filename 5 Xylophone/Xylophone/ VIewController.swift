//
//  ViewController.swift
//  Xylophone
//
//  Created by Angela Yu and Kevin Jackson on 01/27/2016 and 1/12/2019
//  Copyright © 2016 London App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, AVAudioPlayerDelegate {
    
    var player : AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func notePressed(_ sender: UIButton) {
        playSound("note\(sender.tag)")
    }
    
    func playSound(_ url: String) {
        let noteURL = Bundle.main.url(forResource: url, withExtension: "wav")!
        
        do {
            try player = AVAudioPlayer(contentsOf: noteURL)
        }
            
        catch let error as NSError {
            print(error.description)
        }
        
        player.play()
    }
}

