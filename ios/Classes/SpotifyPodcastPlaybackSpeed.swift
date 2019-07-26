//
//  SpotifyPodcastPlaybackSpeed.swift
//  Runner
//
//  Created by Juan Diego Fajardo on 7/15/19.
//  Copyright © 2019 The Chromium Authors. All rights reserved.
//

import Foundation
import SpotifyiOS

class SpotifyPodcastPlaybackSpeed: NSObject, SPTAppRemotePodcastPlaybackSpeed, FlutterChannelCodable, SpotifySDKConvertible {
    var value: NSNumber
    
    typealias T = SPTAppRemotePodcastPlaybackSpeed
    
    required init(fromSdkObject object: SPTAppRemotePodcastPlaybackSpeed) {
        self.value = object.value
    }
    
    required init(fromChannelObject channelObject: FlutterChannelObject) {
        let extractor = CodecResultExtractor(channelObject)
        self.value = extractor.get(CodecKeys.PodcastPlaybackSpeed.value)!
    }
    
    func encode() -> FlutterChannelObject {
        return [CodecKeys.PodcastPlaybackSpeed.value : value]
    }
}
