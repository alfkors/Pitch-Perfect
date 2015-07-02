//
//  PlaySoundsViewController.swift
//  Pitch Perfect
//
//  Created by Mykola Aleshchanov on 5/20/15.
//  Copyright (c) 2015 Mykola Aleshchanov. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {
    var audioPlayer:AVAudioPlayer!
    var receivedAudio:RecordedAudio!
    var audioEngine:AVAudioEngine!
    var audioFile:AVAudioFile!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Initialize AVAudioPlayer and AVAudioEngine objects with data from RecordSoundsViewController
        audioPlayer = AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl, error: nil)
        audioPlayer.enableRate = true
        audioEngine = AVAudioEngine()
        audioFile = AVAudioFile(forReading: receivedAudio.filePathUrl, error: nil)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func stopAudio(sender: UIButton) {
        stopAllAudio()
    }
    
    @IBAction func playSlowAudio(sender: UIButton) {
        playAudioWithVariableRate(0.5)
    }
    
    @IBAction func playFastAudio(sender: UIButton) {
        playAudioWithVariableRate(2.0)
    }
    
    @IBAction func playChipmunkAudio(sender: UIButton) {
        playAudioWithVariablePitch(1000)
     }
    
    @IBAction func playDarthvaderAudio(sender: UIButton) {
        playAudioWithVariablePitch(-1000)
    }
    
    @IBAction func playEchoAudio(sender: UIButton) {
        var echoEffect = AVAudioUnitDelay()
        playEffectsAudio(echoEffect)
    }
    
    @IBAction func playReverbAudio(sender: UIButton) {
        var reverbEffect = AVAudioUnitReverb()
        reverbEffect.loadFactoryPreset(AVAudioUnitReverbPreset.Cathedral)
        reverbEffect.wetDryMix = 30.0
        playEffectsAudio(reverbEffect)
    }
    
    // Play fast and slow
    func playAudioWithVariableRate(rate:Float){
        stopAllAudio()
        audioPlayer.rate = rate
        audioPlayer.play()
    }
    
    // Chipmunk and Darth Vader
    func playAudioWithVariablePitch(pitch:Float){
        var changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        playEffectsAudio(changePitchEffect)
    }
    
    // Play Echo, Reverb and Pitch effects
    func playEffectsAudio(effect:AVAudioUnit){
        stopAllAudio()
        
        var audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        audioEngine.attachNode(effect)
        audioEngine.connect(audioPlayerNode, to: effect, format:nil)
        audioEngine.connect(effect, to: audioEngine.outputNode, format:nil)
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        audioEngine.startAndReturnError(nil)
        audioPlayerNode.play()
    }
    
    func stopAllAudio(){
        audioPlayer.stop()
        audioPlayer.currentTime = 0
        audioEngine.stop()
        audioEngine.reset()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
