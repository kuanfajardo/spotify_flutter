//
//  SpotifyImage.swift
//  Runner
//
//  Created by Juan Diego Fajardo on 7/15/19.
//  Copyright © 2019 The Chromium Authors. All rights reserved.
//

import Foundation
import SpotifyiOS

class SpotifyImage: NSObject, SPTAppRemoteImageRepresentable, FlutterChannelDecodable {
    var imageIdentifier: String
    
    required init(fromCodecResult codecResult: CodecResult) {
        let extractor = CodecResultExtractor(codecResult)
        self.imageIdentifier = extractor.get(CodecKeys.Image.imageIdentifier)!
    }
}
