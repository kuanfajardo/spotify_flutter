//
//  SpotifyCrossfadeState.swift
//  Runner
//
//  Created by Juan Diego Fajardo on 7/15/19.
//  Copyright © 2019 The Chromium Authors. All rights reserved.
//

import Foundation
import SpotifyiOS

class SpotifyCrossfadeState: NSObject, SPTAppRemoteCrossfadeState, FlutterChannelCodable, SpotifySDKConvertible {
    var isEnabled: Bool
    var duration: Int
    
    typealias T = SPTAppRemoteCrossfadeState
    
    required init(fromSdkObject object: SPTAppRemoteCrossfadeState) {
        self.isEnabled = object.isEnabled
        self.duration = object.duration
    }
    
    required init(fromChannelObject channelObject: FlutterChannelObject) {
        let extractor = CodecResultExtractor(channelObject)
        
        self.isEnabled = extractor.get(CodecKeys.CrossfadeState.isEnabled)!
        self.duration = extractor.get(CodecKeys.CrossfadeState.duration)!
    }
    
    func encode() -> FlutterChannelObject {
        return [
            CodecKeys.CrossfadeState.isEnabled: isEnabled,
            CodecKeys.CrossfadeState.duration: duration,
        ]
    }
}
