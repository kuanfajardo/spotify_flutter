//
//  SpotifyPlayerState.swift
//  Runner
//
//  Created by Juan Diego Fajardo on 7/15/19.
//  Copyright © 2019 The Chromium Authors. All rights reserved.
//

import Foundation

class SpotifyPlayerState: NSObject, SPTAppRemotePlayerState {
    var track: SPTAppRemoteTrack
    var playbackPosition: Int
    var playbackSpeed: Float
    var isPaused: Bool
    var playbackRestrictions: SPTAppRemotePlaybackRestrictions
    var playbackOptions: SPTAppRemotePlaybackOptions
    var contextTitle: String
    var contextURI: URL
}
