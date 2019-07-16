//
//  UserAPI.swift
//  Runner
//
//  Created by Juan Diego Fajardo on 7/15/19.
//  Copyright © 2019 The Chromium Authors. All rights reserved.
//

import Foundation

struct UserApiHandler {
    static func handle_fetchCapabilities_withCall(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        SpotifyChannelState.appRemote?.userAPI?.fetchCapabilities { (sdkResult: Any?, error: Error?) in
            guard error == nil else {
                result(sdkError(error!))
                return
            }
            
            guard let capabilities = sdkResult as? SPTAppRemoteUserCapabilities else {
                result(sdkResultUnpackingError(expectedType: SPTAppRemoteUserCapabilities.self))
                return
            }
            
            let encodedCapabilities = SpotifyUserCapabilities(fromSdkObject: capabilities).encode()
            result(encodedCapabilities)
        }
    }
    
    static func handle_subscribeToCapabilityChanges_withCall(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        SpotifyChannelState.appRemote?.userAPI?.subscribe(toCapabilityChanges: { (sdkResult: Any?, error: Error?) in
            guard error == nil else {
                result(sdkError(error!))
                return
            }
            
            // sdkResult is true if error is nil
            result(true)
        })
    }
    
    static func handle_unsubscribeToCapabilityChanges_withCall(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        SpotifyChannelState.appRemote?.userAPI?.unsubscribe(toCapabilityChanges: { (sdkResult: Any?, error: Error?) in
            guard error == nil else {
                result(sdkError(error!))
                return
            }
            
            // sdkResult is true if error is nil
            result(true)
        })
    }
    
    static func handle_fetchLibraryStateForUri_withCall(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let cocoaUri = call.arguments as? NSString else {
            result(argsErrorForCall(call))
            return
        }
        
        let uri = String(cocoaUri)
        
        SpotifyChannelState.appRemote?.userAPI?.fetchLibraryState(forURI: uri) { (sdkResult: Any?, error: Error?) in
            guard error == nil else {
                result(sdkError(error!))
                return
            }
            
            guard let libraryState = sdkResult as? SPTAppRemoteLibraryState else {
                result(sdkResultUnpackingError(expectedType: SPTAppRemoteLibraryState.self))
                return
            }
            
            let encodedLibraryState = SpotifyLibraryState(fromSdkObject: libraryState).encode()
            result(encodedLibraryState)
        }
    }
    
    static func handle_addUriToLibrary_withCall(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let cocoaUri = call.arguments as? NSString else {
            result(argsErrorForCall(call))
            return
        }
        
        let uri = String(cocoaUri)
        
        SpotifyChannelState.appRemote?.userAPI?.addItemToLibrary(withURI: uri) { (sdkResult: Any?, error: Error?) in
            guard error == nil else {
                result(sdkError(error!))
                return
            }
            
            // sdkResult is true if error is nil
            result(true)
        }
    }
    
    static func handle_removeUriFromLibrary_withCall(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let cocoaUri = call.arguments as? NSString else {
            result(argsErrorForCall(call))
            return
        }
        
        let uri = String(cocoaUri)
        
        SpotifyChannelState.appRemote?.userAPI?.removeItemFromLibrary(withURI: uri) { (sdkResult: Any?, error: Error?) in
            guard error == nil else {
                result(sdkError(error!))
                return
            }
            
            // sdkResult is true if error is nil
            result(true)
        }
    }
}
