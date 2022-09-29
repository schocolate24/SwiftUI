//
//  Audio.swift
//  JapaneseLanguage
//
//  Created by 中木翔子 on 2022/09/29.
//
import AVFoundation
import AVKit
import SwiftUI

class Audio: ObservableObject {
    @Published var audioPlayer: AVAudioPlayer!
    
    func playSounds(file soundFileName: String) {
        guard let soundURL = Bundle.main.url(forResource: soundFileName, withExtension: "mp3") else {
            fatalError("Unable to find \(soundFileName) in bundle")
        }
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
        } catch {
            print(error.localizedDescription)
        }
        audioPlayer.play()
    }
}

