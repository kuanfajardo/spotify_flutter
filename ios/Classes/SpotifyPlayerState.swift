//
//  SpotifyPlayerState.swift
//  Runner
//
//  Created by Juan Diego Fajardo on 7/15/19.
//  Copyright © 2019 The Chromium Authors. All rights reserved.
//

import Foundation
import SpotifyiOS

class SpotifyPlayerState: NSObject, SPTAppRemotePlayerState, Codec {
    var track: SPTAppRemoteTrack
    var playbackPosition: Int
    var playbackSpeed: Float
    var isPaused: Bool
    var playbackRestrictions: SPTAppRemotePlaybackRestrictions
    var playbackOptions: SPTAppRemotePlaybackOptions
    var contextTitle: String
    var contextURI: URL
    
    init(fromSdkObject object: SPTAppRemotePlayerState) {
        self.track = object.track
        self.playbackPosition = object.playbackPosition
        self.playbackSpeed = object.playbackSpeed
        self.isPaused = object.isPaused
        self.playbackRestrictions = object.playbackRestrictions
        self.playbackOptions = object.playbackOptions
        self.contextTitle = object.contextTitle
        self.contextURI = object.contextURI
    }
    
    required init(fromCodecResult codecResult: CodecResult) {
        let extractor = CodecResultExtractor(codecResult)
        
        self.track = extractor.get(CodecKeys.PlayerState.track)!
        self.playbackPosition = extractor.get(CodecKeys.PlayerState.playbackPosition)!
        self.playbackSpeed = extractor.get(CodecKeys.PlayerState.playbackSpeed)!
        self.isPaused = extractor.get(CodecKeys.PlayerState.isPaused)!
        self.playbackRestrictions = extractor.get(CodecKeys.PlayerState.playbackRestrictions)!
        self.playbackOptions = extractor.get(CodecKeys.PlayerState.playbackOptions)!
        self.contextTitle = extractor.get(CodecKeys.PlayerState.contextTitle)!
        self.contextURI = extractor.get(CodecKeys.PlayerState.contextUri)!
    }
    
    func encode() -> CodecResult {
        return [
            CodecKeys.PlayerState.track: track,
            CodecKeys.PlayerState.playbackPosition: playbackPosition,
            CodecKeys.PlayerState.playbackSpeed: playbackSpeed,
            CodecKeys.PlayerState.isPaused: isPaused,
            CodecKeys.PlayerState.playbackRestrictions: playbackRestrictions,
            CodecKeys.PlayerState.playbackOptions: playbackOptions,
            CodecKeys.PlayerState.contextTitle: contextTitle,
            CodecKeys.PlayerState.contextUri: contextURI,
        ]
    }
}
