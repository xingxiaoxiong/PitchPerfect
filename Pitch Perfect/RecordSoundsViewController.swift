//
//  RecordSoundsViewController.swift
//  Pitch Perfect
//
//  Created by shapeare on 6/7/15.
//  Copyright (c) 2015 BettyBearStudio. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {
    
    @IBOutlet weak var recordingInProgress: UILabel!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    
    @IBOutlet weak var pauseButton: UIButton!
    @IBOutlet weak var resumeButton: UIButton!
    
    var audioRecorder: AVAudioRecorder!
    var recordedAudio: RecordedAudio!
    
    override func viewWillAppear(animated: Bool) {
        stopButton.hidden = true
        setPauseButtonState(true, enabled: false)
        setResumeButtonState(true, enabled: false)
        recordButton.enabled = true
        recordingInProgress.text = "Tap to record"
    }

    @IBAction func recordAudio(sender: UIButton) {
        stopButton.hidden = false
        recordingInProgress.text = "Recording in progress"
        setPauseButtonState(false, enabled: true)
        recordButton.enabled = false
        
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as! String
        
        let recordingName = "my_audio.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = NSURL.fileURLWithPathComponents(pathArray)
        
        var session = AVAudioSession.sharedInstance()
        session.setCategory(AVAudioSessionCategoryPlayAndRecord, error: nil)
        
        audioRecorder = AVAudioRecorder(URL: filePath, settings: nil, error: nil)
        audioRecorder.delegate = self
        audioRecorder.meteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }
    
    @IBAction func pauseRecord(sender: UIButton) {
        setPauseButtonState(true, enabled: false)
        setResumeButtonState(false, enabled: true)
        audioRecorder.pause()
        recordingInProgress.text = "Recording paused"
    }
    
    @IBAction func resumeRecord(sender: UIButton) {
        setResumeButtonState(true, enabled: false)
        setPauseButtonState(false, enabled: true)
        audioRecorder.record()
        recordingInProgress.text = "Recording in progress"
    }

    @IBAction func stopAudio(sender: UIButton) {
        setPauseButtonState(true, enabled: false)
        setResumeButtonState(true, enabled: false)
        
        audioRecorder.stop()
        var audioSession = AVAudioSession.sharedInstance()
        audioSession.setActive(false, error: nil)
    }
    
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder!, successfully flag: Bool) {
        if flag{
            recordedAudio = RecordedAudio(filePathUrl: recorder.url, title: recorder.url.lastPathComponent)
            self.performSegueWithIdentifier("stopRecording", sender: recordedAudio)
        }else{
            var alert = UIAlertController(title: "Alert", message: "Message", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "Click", style: .Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
            
            recordButton.enabled = true
            stopButton.hidden = true
        }
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "stopRecording"{
            let playingSoundsVC = segue.destinationViewController as! PlaySoundsViewController
            let data = sender as! RecordedAudio
            playingSoundsVC.receivedAudio = data
        }
    }
    
    func setResumeButtonState(hidden: Bool, enabled: Bool) {
        resumeButton.hidden = hidden
        resumeButton.enabled = enabled
    }
    
    func setPauseButtonState(hidden: Bool, enabled: Bool) {
        pauseButton.hidden = hidden
        pauseButton.enabled = enabled
    }
    
}

