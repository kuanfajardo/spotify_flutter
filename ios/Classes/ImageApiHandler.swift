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
        
        guard let imageItemObject = args.object(forKey: HandlerKeys.ImageApi.imageItem) as? NSDictionary as? FlutterChannelObject else {
            result(keyCastError(HandlerKeys.ImageApi.imageItem, expectedType: NSDictionary.self))
            return
        }
        
        guard let sizeObject = args.object(forKey: HandlerKeys.ImageApi.size) as? NSDictionary as? FlutterChannelObject else {
            result(keyCastError(HandlerKeys.ImageApi.size, expectedType: NSDictionary.self))
            return
        }
        
        let imageItem = SpotifyImageRepresentable(fromChannelObject: imageItemObject)
        let size = CGSize(fromChannelObject: sizeObject)
        
        SwiftSpotifyPlugin.instance.appRemote?.imageAPI?.fetchImage(forItem: imageItem, with: size) { (sdkResult: Any?, error: Error?) in
            guard error == nil else {
                result(sdkError(error!))
                return
            }
            
            guard let image = sdkResult as? UIImage else {
                result(sdkResultUnpackingError(expectedType: UIImage.self))
                return
            }
            
            let encodedImage = image.encode()
            result(encodedImage)
        }
    }
}
