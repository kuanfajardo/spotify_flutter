//
//  SPTConfiguration+Codec.swift
//  Runner
//
//  Created by Juan Diego Fajardo on 7/17/19.
//  Copyright © 2019 The Chromium Authors. All rights reserved.
//

import Foundation
import SpotifyiOS

extension SPTConfiguration {
    static func configurationFromCodecObject(_ codecResult: CodecResult) -> SPTConfiguration {
        let extractor = CodecResultExtractor(codecResult)
        
        let clientID: String = extractor.get(CodecKeys.Configuration.clientId)!
        let rediructURLString: String = extractor.get(CodecKeys.Configuration.redirectUrl)!
        let playURI: String? = extractor.get(CodecKeys.Configuration.playUri)
        let tokenSwapURLString: String? = extractor.get(CodecKeys.Configuration.tokenSwapUrl)
        let tokenRefreshURLString: String? = extractor.get(CodecKeys.Configuration.tokenRefreshUrl)
        
        let redirectURL = URL(string: rediructURLString)
        
        let configuration = SPTConfiguration(clientID: clientID, redirectURL: redirectURL!)
        configuration.playURI = playURI
        
        if tokenSwapURLString != nil {
        configuration.tokenSwapURL = URL(string: tokenSwapURLString!)
        }
        
        if tokenRefreshURLString != nil {
        configuration.tokenRefreshURL = URL(string: tokenRefreshURLString!)
        }
        
        return configuration
    }
}
