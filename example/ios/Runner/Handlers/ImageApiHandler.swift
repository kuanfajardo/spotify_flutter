//
//  ImageAPI.swift
//  Runner
//
//  Created by Juan Diego Fajardo on 7/15/19.
//  Copyright © 2019 The Chromium Authors. All rights reserved.
//

import Foundation

struct ImageApiHandler {
    static func handle_fetchImageForItem_withCall(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let args = call.arguments as? NSDictionary else {
            result(argsErrorForCall(call))
            return
        }
        
        guard let imageItemObject = args.object(forKey: Keys.ImageApi.imageItem) as? NSDictionary else {
            result(keyCastError(Keys.ImageApi.imageItem, expectedType: NSDictionary.self))
            return
        }
        
        guard let sizeObject = args.object(forKey: Keys.ImageApi.size) as? NSDictionary else {
            result(keyCastError(Keys.ImageApi.size, expectedType: NSDictionary.self))
            return
        }
        
        // TODO: Decode imageItemObject
        let imageItem: SPTAppRemoteImageRepresentable
        
        // TODO: Decode sizeObject
        let size: CGSize
        
        SpotifyChannelState.appRemote?.imageAPI?.fetchImage(forItem: imageItem, with: size) { (sdkResult: Any?, error: Error?) in
            guard error == nil else {
                result(sdkError(error!))
                return
            }
            
            guard let image = sdkResult as? UIImage else {
                result(sdkResultUnpackingError(expectedType: UIImage.self))
                return
            }
            
            // TODO: Codec image
            result(FlutterMethodNotImplemented)
        }
    }
}
