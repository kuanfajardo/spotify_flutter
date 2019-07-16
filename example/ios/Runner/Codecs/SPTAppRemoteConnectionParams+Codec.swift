//
//  SPTAppRemoteConnectionParams.swift
//  Runner
//
//  Created by Juan Diego Fajardo on 7/17/19.
//  Copyright © 2019 The Chromium Authors. All rights reserved.
//

import Foundation

extension SPTAppRemoteConnectionParams {
    func encode() -> CodecResult {
        return [
            CodecKeys.ConnectionParams.accessToken: self.accessToken,
            CodecKeys.ConnectionParams.defaultImageSize: self.defaultImageSize,
            CodecKeys.ConnectionParams.imageFormat: self.imageFormat,
            CodecKeys.ConnectionParams.protocolVersion: self.protocolVersion,
        ]
    }
    
    static func connectionParamsFromCodecObject(_ codecResult: CodecResult?) -> SPTAppRemoteConnectionParams? {
        guard codecResult != nil else {
            return nil
        }
        
        let extractor = CodecResultExtractor(codecResult!)
        
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
        
        let connectionParams = SPTAppRemoteConnectionParams(accessToken: accessToken, defaultImageSize: defaultImageSize, imageFormat: imageFormat)
        
        return connectionParams
    }
}
