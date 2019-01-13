//
//  ViewController.swift
//  Dicee
//
//  Created by Kevin Jackson on 1/11/19.
//  Copyright © 2019 Kevin Jackson. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let diceImages = [
        "dice1",
        "dice2",
        "dice3",
        "dice4",
        "dice5",
        "dice6"
    ]
    @IBOutlet weak var diceImageView1: UIImageView!
    @IBOutlet weak var diceImageView2: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        randomizeDice()
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        randomizeDice()
    }
    
    @IBAction func rollButtonPressed(_ sender: UIButton) {
        randomizeDice()
    }
    
    // Changes dice images
    func randomizeDice() {
        let diceRange = 0...diceImages.count-1
        diceImageView1.image = UIImage(named: diceImages[Int.random(in: diceRange)])
        diceImageView2.image = UIImage(named: diceImages[Int.random(in: diceRange)])
    }
    
}
