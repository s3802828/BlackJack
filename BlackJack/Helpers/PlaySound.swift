/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2022B
  Assessment: Assignment 2
  Author: Le Quynh Giang
  ID: s3802828
  Created  date: 22/08/2022
  Last modified: 24/08/2022
  Acknowledgement:
 T.Huynh."RMIT-Casino/RMIT Casino/Helpers/PlaySound.swift".GitHub.https://github.com/TomHuynhSG/RMIT-Casino/blob/main/RMIT%20Casino/Helpers/PlaySound.swift (accessed Aug. 22, 2022)

 */

import AVFoundation

var audioPlayer: AVAudioPlayer?
var audioPlayer2: AVAudioPlayer?

func playSound(sound: String, type: String) {
    if let path = Bundle.main.path(forResource: sound, ofType: type) {
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
            //If the sound is "welcome" song, make it inifinitely loop because this is background music
            if sound == "welcome" {
                audioPlayer?.numberOfLoops = -1
            }
            audioPlayer?.play()
        } catch {
            print("ERROR: Could not find and play the sound file!")
        }
    }
}
//Play another sound on top of the background music
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

func pausePlayer(){
    audioPlayer?.pause()
}

func pausePlayer2(){
    audioPlayer2?.pause()
}

func resumePlayer(){
    audioPlayer?.play()
}

func resumePlayer2(){
    audioPlayer2?.play()
}

