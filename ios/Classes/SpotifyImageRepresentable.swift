//
//  SpotifyImageRepresentable.swift
//  Runner
//
//  Created by Juan Diego Fajardo on 7/15/19.
//  Copyright © 2019 The Chromium Authors. All rights reserved.
//

import Foundation
import SpotifyiOS

class SpotifyImageRepresentable: NSObject, SPTAppRemoteImageRepresentable, FlutterChannelDecodable {
    var imageIdentifier: String
    
    required init(fromChannelObject channelObject: FlutterChannelObject) {
        let extractor = CodecResultExtractor(channelObject)
        self.imageIdentifier = extractor.get(CodecKeys.Image.imageIdentifier)!
    }
}
