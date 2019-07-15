//
//  ContentAPI.swift
//  Runner
//
//  Created by Juan Diego Fajardo on 7/15/19.
//  Copyright © 2019 The Chromium Authors. All rights reserved.
//

import Foundation

struct ContentApiHandler {
    static func handle_fetchRootContentItemsForType_withCall(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let rawContentType = call.arguments as? NSNumber else {
            result(argsErrorForCall(call))
            return
        }
        
        let contentType = contentTypeForRawValue(rawContentType)
        
        SpotifyChannelState.appRemote?.contentAPI?.fetchRootContentItems(forType: contentType) { (sdkResult: Any?, error: Error?) in
            guard error == nil else {
                result(sdkError(error!))
                return
            }
            
            guard let contentItems = sdkResult as? Array<SPTAppRemoteContentItem> else {
                result(sdkResultUnpackingError(expectedType: Array<SPTAppRemoteContentItem>.self))
                return
            }
            
            // TODO: Codec contentItems
            result(FlutterMethodNotImplemented)
        }
    }
    
    static func handle_fetchChildrenOfContentItem_withCall(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let contentItemObject = call.arguments as? NSDictionary else {
            result(argsErrorForCall(call))
            return
        }
        
        // TODO: Decode contentItemObject
        let contentItem: SPTAppRemoteContentItem
        
        SpotifyChannelState.appRemote?.contentAPI?.fetchChildren(of: contentItem) { (sdkResult: Any?, error: Error?) in
            guard error == nil else {
                result(sdkError(error!))
                return
            }
            
            guard let children = sdkResult as? Array<SPTAppRemoteContentItem> else {
                result(sdkResultUnpackingError(expectedType: Array<SPTAppRemoteContentItem>.self))
                return
            }
            
            // TODO: Codec children
            result(FlutterMethodNotImplemented)
        }
    }
    
    static func handle_fetchRecommendedContentItemsForType_withCall(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let args = call.arguments as? NSDictionary else {
            result(argsErrorForCall(call))
            return
        }
        
        guard let rawContentType = args.object(forKey: Keys.ContentApi.contentType) as? NSNumber else {
            // TODO: KEY CAST ERROR
            return
        }
        
        guard let cocoaFlattenContainers = args.object(forKey: Keys.ContentApi.flattenContainers) as? NSNumber else {
            // TODO: KEY CAST ERROR
            return
        }
        
        let contentType = contentTypeForRawValue(rawContentType)
        
        guard let flattenContainers = Bool(exactly: cocoaFlattenContainers) else {
            // TODO: VALUE CAST ERROR
            return
        }
        
        SpotifyChannelState.appRemote?.contentAPI?.fetchRecommendedContentItems(forType: contentType, flattenContainers: flattenContainers) { (sdkResult: Any?, error: Error?) in
            guard error == nil else {
                result(sdkError(error!))
                return
            }
            
            guard let contentItems = sdkResult as? Array<SPTAppRemoteContentItem> else {
                result(sdkResultUnpackingError(expectedType:  Array<SPTAppRemoteContentItem>.self))
                return
            }
            
            // TODO: Codec contentItems
            result(FlutterMethodNotImplemented)
        }
    }
}

private func contentTypeForRawValue(_ value: NSNumber) -> String {
    switch value {
    case 0:
        return SPTAppRemoteContentTypeDefault
    case 1:
        return SPTAppRemoteContentTypeNavigation
    case 2:
        return SPTAppRemoteContentTypeFitness
    default:
        return SPTAppRemoteContentTypeDefault
    }
}
