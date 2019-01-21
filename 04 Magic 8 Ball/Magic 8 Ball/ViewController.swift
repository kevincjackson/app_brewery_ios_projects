//
//  ViewController.swift
//  Magic 8 Ball
//
//  Created by Kevin Jackson on 1/11/19.
//  Copyright © 2019 Kevin Jackson. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let ballArray = [
        "ball1",
        "ball2",
        "ball3",
        "ball4",
        "ball5"
    ]
    
    var randomBallNumber = 0
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBAction func askButtonPressed(_ sender: UIButton) {
        randomizeBall()
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        randomizeBall()
    }
    
    fileprivate func randomizeBall() {
        randomBallNumber = Int.random(in: 0...(ballArray.count - 1))
        imageView.image = UIImage(named: ballArray[randomBallNumber])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        randomizeBall()
    }
}
