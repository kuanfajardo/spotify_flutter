//
//  SpotifyUserCapabilities.swift
//  Runner
//
//  Created by Juan Diego Fajardo on 7/15/19.
//  Copyright © 2019 The Chromium Authors. All rights reserved.
//

import Foundation
import SpotifyiOS

class SpotifyUserCapabilities: NSObject, SPTAppRemoteUserCapabilities, FlutterChannelCodable, SpotifySDKConvertible {
    var canPlayOnDemand: Bool
    
    typealias T = SPTAppRemoteUserCapabilities
    
    required init(fromSdkObject object: SPTAppRemoteUserCapabilities) {
        self.canPlayOnDemand = object.canPlayOnDemand
    }
    
    required init(fromChannelObject channelObject: FlutterChannelObject) {
        let extractor = CodecResultExtractor(channelObject)
        self.canPlayOnDemand = extractor.get(CodecKeys.UserCapabilities.canPlayOnDemand)!
    }
    
    func encode() -> FlutterChannelObject {
        return [CodecKeys.UserCapabilities.canPlayOnDemand : canPlayOnDemand]
    }
}
