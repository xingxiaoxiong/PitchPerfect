//
//  ViewController.swift
//  Pitch Perfect
//
//  Created by shapeare on 6/7/15.
//  Copyright (c) 2015 BettyBearStudio. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var recordingInProgress: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func recordAudio(sender: UIButton) {
        recordingInProgress.hidden = false
        println("recording")
    }

    @IBAction func stopAudio(sender: UIButton) {
        recordingInProgress.hidden = true
    }
}

