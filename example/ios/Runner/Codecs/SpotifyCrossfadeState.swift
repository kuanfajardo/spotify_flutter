//
//  SpotifyCrossfadeState.swift
//  Runner
//
//  Created by Juan Diego Fajardo on 7/15/19.
//  Copyright © 2019 The Chromium Authors. All rights reserved.
//

import Foundation

class SpotifyCrossfadeState: NSObject, SPTAppRemoteCrossfadeState, Codec {
    var isEnabled: Bool
    var duration: Int
    
    init(fromSdkObject object: SPTAppRemoteCrossfadeState) {
        self.isEnabled = object.isEnabled
        self.duration = object.duration
    }
    
    required init(fromCodecResult codecResult: CodecResult) {
        let extractor = CodecResultExtractor(codecResult)
        
        self.isEnabled = extractor.get(CodecKeys.CrossfadeState.isEnabled)!
        self.duration = extractor.get(CodecKeys.CrossfadeState.duration)!
    }
    
    func encode() -> CodecResult {
        return [
            CodecKeys.CrossfadeState.isEnabled: isEnabled,
            CodecKeys.CrossfadeState.duration: duration,
        ]
    }
}
