//
//  SPTAppRemoteConnectionParams.swift
//  Runner
//
//  Created by Juan Diego Fajardo on 7/17/19.
//  Copyright © 2019 The Chromium Authors. All rights reserved.
//

import Foundation
import SpotifyiOS

class SpotifyAppRemoteConnectionParams: SPTAppRemoteConnectionParams, Codec, SpotifySDKConvertible {
    typealias T = SPTAppRemoteConnectionParams
    
    required init(fromSdkObject object: SPTAppRemoteConnectionParams) {
        super.init(accessToken: object.accessToken, defaultImageSize: object.defaultImageSize, imageFormat: object.imageFormat)
    }
    
    required init(fromCodecResult codecResult: CodecResult) {
        let extractor = CodecResultExtractor(codecResult)
        
        let accessToken: String? = extractor.get(CodecKeys.ConnectionParams.accessToken)
        let defaultImageSizeObject: CodecResult? = extractor.get(CodecKeys.ConnectionParams.defaultImageSize)
        let rawImageFormat: NSNumber? = extractor.get(CodecKeys.ConnectionParams.imageFormat)
        
        var defaultImageSize: CGSize = CGSize.zero
        if defaultImageSizeObject != nil {
            let extractor = CodecResultExtractor(defaultImageSizeObject!)
            
            let width: Double = extractor.get(CodecKeys.CodecableSize.width)!
            let height: Double = extractor.get(CodecKeys.CodecableSize.height)!
            
            defaultImageSize = CGSize(width: width, height: height)
        }
        
        var imageFormat: SPTAppRemoteConnectionParamsImageFormat = .any
        if rawImageFormat != nil {
            let tempImageFormat = SPTAppRemoteConnectionParamsImageFormat(rawValue: rawImageFormat!.uintValue)
            if tempImageFormat != nil {
                imageFormat = tempImageFormat!
            }
        }
        
        super.init(accessToken: accessToken, defaultImageSize: defaultImageSize, imageFormat: imageFormat)
    }
    
    func encode() -> CodecResult {
        return [
            CodecKeys.ConnectionParams.accessToken: self.accessToken,
            CodecKeys.ConnectionParams.defaultImageSize: self.defaultImageSize,
            CodecKeys.ConnectionParams.imageFormat: self.imageFormat.rawValue,
            CodecKeys.ConnectionParams.protocolVersion: self.protocolVersion,
        ]
    }
}
