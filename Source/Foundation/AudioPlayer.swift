//
//  AudioPlayer.swift
//  DarkSwift
//
//  Created by Dark Dong on 16/7/15.
//  Copyright © 2016年 Dark Dong. All rights reserved.
//

import Foundation
import AVFoundation

public class AudioPlayer: NSObject {
    public static let shared = AudioPlayer()
    
    private var player: AVAudioPlayer?
    private var completionHandler: ((URL?, Bool) -> Void)?
    
    //play long audio file such as background music, song music, etc.
    //This method can enter background mode and recover properly in foreground mode
    public func play(file: URL?, delay: TimeInterval = 0, numberOfLoops: Int = 0, volume: Float = 1, completionHandler: ((URL?, Bool) -> Void)? = nil) {
        guard let file = file else {
            return
        }
        
        if let player = try? AVAudioPlayer(contentsOf: file) {
            play(player: player, delay: delay, numberOfLoops: numberOfLoops, volume: volume, completionHandler: completionHandler)
        }
    }
    
    public func play(data: Data?, delay: TimeInterval = 0, numberOfLoops: Int = 0, volume: Float = 1, completionHandler: ((URL?, Bool) -> Void)? = nil) {
        guard let data = data else {
            return
        }
        
        if let player = try? AVAudioPlayer(data: data) {
            play(player: player, delay: delay, numberOfLoops: numberOfLoops, volume: volume, completionHandler: completionHandler)
        }
    }
    
    public func pause() {
        player?.pause()
    }
    
    public func stop() {
        player?.stop()
    }
    
    private func play(player: AVAudioPlayer, delay: TimeInterval = 0, numberOfLoops: Int = 0, volume: Float = 1, completionHandler: ((URL?, Bool) -> Void)? = nil) {
        player.volume = volume
        player.numberOfLoops = numberOfLoops
        player.delegate = self
        if delay == 0 {
            player.play()
        } else {
            player.play(atTime: player.deviceCurrentTime + delay)
        }
        self.player = player
        self.completionHandler = completionHandler
    }
}

//MARK: - AVAudioPlayerDelegate

extension AudioPlayer: AVAudioPlayerDelegate {
    @objc public func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        completionHandler?(player.url, flag)
    }
}
