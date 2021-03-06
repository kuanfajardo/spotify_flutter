//
//  ContentAPI.swift
//  Runner
//
//  Created by Juan Diego Fajardo on 7/15/19.
//  Copyright © 2019 The Chromium Authors. All rights reserved.
//

import Foundation
import SpotifyiOS

struct ContentApiHandler {
    func handle(fetchRootContentItemsForType call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let rawContentType = call.arguments as? NSNumber else {
            result(argsErrorForCall(call))
            return
        }
        
        let contentType = contentTypeForRawValue(rawContentType)
        
        SwiftSpotifyPlugin.instance.appRemote?.contentAPI?.fetchRootContentItems(forType: contentType) { (sdkResult: Any?, error: Error?) in
            guard error == nil else {
                result(sdkError(error!))
                return
            }
            
            guard let contentItems = sdkResult as? Array<SPTAppRemoteContentItem> else {
                result(sdkResultUnpackingError(expectedType: Array<SPTAppRemoteContentItem>.self))
                return
            }
            
            var encodedContentItems = [FlutterChannelObject]()
            contentItems.forEach({ (contentItem: SPTAppRemoteContentItem) in
                let concreteContentItem = SpotifyContentItem(fromSdkObject: contentItem)
                encodedContentItems.append(concreteContentItem.encode())
            })
            
            result(encodedContentItems)
        }
    }
    
    func handle(fetchChildrenOfContentItem call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let contentItemObject = call.arguments as? NSDictionary as? FlutterChannelObject else {
            result(argsErrorForCall(call))
            return
        }
        
        let contentItem = SpotifyContentItem.init(fromChannelObject: contentItemObject)
        
        SwiftSpotifyPlugin.instance.appRemote?.contentAPI?.fetchChildren(of: contentItem) { (sdkResult: Any?, error: Error?) in
            guard error == nil else {
                result(sdkError(error!))
                return
            }
            
            guard let children = sdkResult as? Array<SPTAppRemoteContentItem> else {
                result(sdkResultUnpackingError(expectedType: Array<SPTAppRemoteContentItem>.self))
                return
            }
            
            var encodedChildren = [FlutterChannelObject]()
            children.forEach({ (child: SPTAppRemoteContentItem) in
                let concreteChild = SpotifyContentItem(fromSdkObject: child)
                encodedChildren.append(concreteChild.encode())
            })
            
            result(encodedChildren)
        }
    }
    
    func handle(fetchRecommendedContentItemsForType call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let args = call.arguments as? NSDictionary else {
            result(argsErrorForCall(call))
            return
        }
        
        guard let rawContentType = args.object(forKey: HandlerKeys.ContentApi.contentType) as? NSNumber else {
            result(keyCastError(HandlerKeys.ContentApi.contentType, expectedType: NSNumber.self))
            return
        }
        
        guard let cocoaFlattenContainers = args.object(forKey: HandlerKeys.ContentApi.flattenContainers) as? NSNumber else {
            result(keyCastError(HandlerKeys.ContentApi.flattenContainers, expectedType: NSNumber.self))
            return
        }
        
        let contentType = contentTypeForRawValue(rawContentType)
        
        guard let flattenContainers = Bool(exactly: cocoaFlattenContainers) else {
            result(valueCastError("cocoaFlattenContainers", expectedType: Bool.self))
            return
        }
        
        SwiftSpotifyPlugin.instance.appRemote?.contentAPI?.fetchRecommendedContentItems(forType: contentType, flattenContainers: flattenContainers) { (sdkResult: Any?, error: Error?) in
            guard error == nil else {
                result(sdkError(error!))
                return
            }
            
            guard let contentItems = sdkResult as? Array<SPTAppRemoteContentItem> else {
                result(sdkResultUnpackingError(expectedType:  Array<SPTAppRemoteContentItem>.self))
                return
            }
            
            var encodedContentItems = [FlutterChannelObject]()
            contentItems.forEach({ (contentItem: SPTAppRemoteContentItem) in
                let concreteContentItem = SpotifyContentItem(fromSdkObject: contentItem)
                encodedContentItems.append(concreteContentItem.encode())
            })
            
            result(encodedContentItems)
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
