//
//  SpotifyUserCapabilities.swift
//  Runner
//
//  Created by Juan Diego Fajardo on 7/15/19.
//  Copyright © 2019 The Chromium Authors. All rights reserved.
//

import Foundation
import SpotifyiOS

class SpotifyUserCapabilities: NSObject, SPTAppRemoteUserCapabilities, Codec {
    var canPlayOnDemand: Bool
    
    init(fromSdkObject object: SPTAppRemoteUserCapabilities) {
        self.canPlayOnDemand = object.canPlayOnDemand
    }
    
    required init(fromCodecResult codecResult: CodecResult) {
        let extractor = CodecResultExtractor(codecResult)
        self.canPlayOnDemand = extractor.get(CodecKeys.UserCapabilities.canPlayOnDemand)!
    }
    
    func encode() -> CodecResult {
        return [CodecKeys.UserCapabilities.canPlayOnDemand : canPlayOnDemand]
    }
}
