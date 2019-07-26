//
//  SPTConfiguration+Codec.swift
//  Runner
//
//  Created by Juan Diego Fajardo on 7/17/19.
//  Copyright © 2019 The Chromium Authors. All rights reserved.
//

import Foundation
import SpotifyiOS

class SpotifyConfiguration: SPTConfiguration, FlutterChannelDecodable {    
    required init(fromCodecResult codecResult: CodecResult) {
        let extractor = CodecResultExtractor(codecResult)
        
        let clientID: String = extractor.get(CodecKeys.Configuration.clientId)!
        let rediructURLString: String = extractor.get(CodecKeys.Configuration.redirectUrl)!
        let playURI: String? = extractor.get(CodecKeys.Configuration.playUri)
        let tokenSwapURLString: String? = extractor.get(CodecKeys.Configuration.tokenSwapUrl)
        let tokenRefreshURLString: String? = extractor.get(CodecKeys.Configuration.tokenRefreshUrl)
        
        let redirectURL = URL(string: rediructURLString)!
        
        super.init(clientID: clientID, redirectURL: redirectURL)
        
        self.playURI = playURI
        
        if tokenSwapURLString != nil {
            self.tokenSwapURL = URL(string: tokenSwapURLString!)
        }
        
        if tokenRefreshURLString != nil {
            self.tokenRefreshURL = URL(string: tokenRefreshURLString!)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
