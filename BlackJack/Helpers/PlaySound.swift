//
//  PlaySound.swift
//  BlackJack
//
//  Created by Giang Le on 22/08/2022.
//

import AVFoundation

var audioPlayer: AVAudioPlayer?
var audioPlayer2: AVAudioPlayer?

func playSound(sound: String, type: String) {
    if let path = Bundle.main.path(forResource: sound, ofType: type) {
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
            if sound == "welcome" {
                audioPlayer?.numberOfLoops = -1
            }
            audioPlayer?.play()
        } catch {
            print("ERROR: Could not find and play the sound file!")
        }
    }
}

func playSound2(sound: String, type: String) {
    if let path = Bundle.main.path(forResource: sound, ofType: type) {
        do {
            audioPlayer2 = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
            if sound == "welcome" {
                audioPlayer2?.numberOfLoops = -1
            }
            audioPlayer2?.play()
        } catch {
            print("ERROR: Could not find and play the sound file!")
        }
    }
}

func stopPlayer(){
    audioPlayer?.stop()
}

func stopPlayer2(){
    audioPlayer?.stop()
}
