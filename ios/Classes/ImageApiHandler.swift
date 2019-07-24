//
//  ImageAPI.swift
//  Runner
//
//  Created by Juan Diego Fajardo on 7/15/19.
//  Copyright © 2019 The Chromium Authors. All rights reserved.
//

import Foundation
import UIKit
import SpotifyiOS

struct ImageApiHandler {
    func handle(fetchImageForItem call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let args = call.arguments as? NSDictionary else {
            result(argsErrorForCall(call))
            return
        }
        
        guard let imageItemObject = args.object(forKey: HandlerKeys.ImageApi.imageItem) as? NSDictionary as? CodecResult else {
            result(keyCastError(HandlerKeys.ImageApi.imageItem, expectedType: NSDictionary.self))
            return
        }
        
        guard let sizeObject = args.object(forKey: HandlerKeys.ImageApi.size) as? NSDictionary as? CodecResult else {
            result(keyCastError(HandlerKeys.ImageApi.size, expectedType: NSDictionary.self))
            return
        }
        
        let imageItem = SpotifyImage(fromCodecResult: imageItemObject)
        let size = self.sizeFromCodecResult(sizeObject)
        
        SwiftSpotifyPlugin.instance.appRemote?.imageAPI?.fetchImage(forItem: imageItem, with: size) { (sdkResult: Any?, error: Error?) in
            guard error == nil else {
                result(sdkError(error!))
                return
            }
            
            guard let image = sdkResult as? UIImage else {
                result(sdkResultUnpackingError(expectedType: UIImage.self))
                return
            }
            
            let encodedImage = self.codecObjectFromImage(image)
            result(encodedImage)
        }
    }
    
    private func sizeFromCodecResult(_ codecResult: CodecResult) -> CGSize {
        let extractor = CodecResultExtractor(codecResult)
        
        let width: Double = extractor.get(CodecKeys.CodecableSize.width)!
        let height: Double = extractor.get(CodecKeys.CodecableSize.height)!
        
        return CGSize(width: width, height: height)
    }
    
    private func codecObjectFromImage(_ image: UIImage) -> CodecResult {
        let imageData = UIImagePNGRepresentation(image)
        return [
            CodecKeys.CodecableImage.imageData: imageData
        ]
    }
}
