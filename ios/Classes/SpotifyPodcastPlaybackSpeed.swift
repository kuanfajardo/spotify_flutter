//
//  SpotifyPodcastPlaybackSpeed.swift
//  Runner
//
//  Created by Juan Diego Fajardo on 7/15/19.
//  Copyright © 2019 The Chromium Authors. All rights reserved.
//

import Foundation
import SpotifyiOS

class SpotifyPodcastPlaybackSpeed: NSObject, SPTAppRemotePodcastPlaybackSpeed, Codec {
    var value: NSNumber
    
    init(fromSdkObject object: SPTAppRemotePodcastPlaybackSpeed) {
        self.value = object.value
    }
    
    required init(fromCodecResult codecResult: CodecResult) {
        let extractor = CodecResultExtractor(codecResult)
        self.value = extractor.get(CodecKeys.PodcastPlaybackSpeed.value)!
    }
    
    func encode() -> CodecResult {
        return [CodecKeys.PodcastPlaybackSpeed.value : value]
    }
}
