//
//  SoundManager.swift
//  poke-gacha
//
//  Created by James Ellis on 11/28/25.
//
import AVFoundation

class SoundManager {
    static let shared = SoundManager()
    private var player: AVAudioPlayer?
    
    func playSound(named: String) {
        guard let url = Bundle.main.url(forResource: named, withExtension: "wav") else {
            print("Sound file not found")
            return
        }
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        } catch {
            print("Error playing sound: \(error)")
        }
    }
}
