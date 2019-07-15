//
//  AppRemoteHandler.swift
//  Runner
//
//  Created by Juan Diego Fajardo on 7/15/19.
//  Copyright © 2019 The Chromium Authors. All rights reserved.
//

import Foundation

struct AppRemoteHandler {
    static func handle_checkIfSpotifyAppIsActive_withCall(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        SPTAppRemote.checkIfSpotifyAppIsActive { (isActive: Bool) in
            result(isActive)
        }
    }
    
    static func handle_version_withCall(_ call: FlutterMethodCall, result: FlutterResult) {
        let version = SPTAppRemote.version()
        result(version)
    }
    
    static func handle_spotifyItunesItemIdentifier_withCall(_ call: FlutterMethodCall, result: FlutterResult) {
        let itunesItemIdentifier: NSNumber = SPTAppRemote.spotifyItunesItemIdentifier()
        result(itunesItemIdentifier)
    }
    
    static func handle_initializeAppRemote_withCall(_ call: FlutterMethodCall, result: FlutterResult) {
        guard let args = call.arguments as? NSDictionary else {
            result(argsErrorForCall(call))
            return
        }
        
        guard let configurationObject = args.object(forKey: Keys.AppRemote.configuration) as? NSDictionary else {
            result(keyCastError(Keys.AppRemote.configuration, expectedType: NSDictionary.self))
            return
        }
        
        guard let rawLogLevel = args.object(forKey: Keys.AppRemote.logLevel) as? NSNumber else {
            result(keyCastError(Keys.AppRemote.logLevel, expectedType: NSNumber.self))
            return
        }
        
        let connectionParamsObject = args.object(forKey: Keys.AppRemote.connectionParams) as? NSDictionary
        
        // TODO: Decode configurationObject
        let configuration: SPTConfiguration
        
        guard let logLevel = SPTAppRemoteLogLevel(rawValue: rawLogLevel.uintValue) else {
            result(valueCastError("rawLogLevel", expectedType: SPTAppRemoteLogLevel.self))
            return
        }
        
        // TODO: Decode connectionParamsObject (optional)
        let connectionParams: SPTAppRemoteConnectionParams? = nil
        
        let appRemote: SPTAppRemote
        
        if connectionParams != nil {
            appRemote = SPTAppRemote(configuration: configuration, connectionParameters: connectionParams!, logLevel: logLevel)
        } else {
            appRemote = SPTAppRemote(configuration: configuration, logLevel: logLevel)
        }
        
        // Set state
        SpotifyChannelState.appRemote = appRemote
        
        result(true)
    }
    
    static func handle_connectionParameters_withCall(_ call: FlutterMethodCall, result: FlutterResult) {
        guard let connectionParams = SpotifyChannelState.appRemote?.connectionParameters else {
            result(unavailableSdkValueError("AppRemote.connectionParameters"))
            return
        }
        
        // TODO: Encode connectionParams
        result(FlutterMethodNotImplemented)
    }
    
    static func handle_isConnected_withCall(_ call: FlutterMethodCall, result: FlutterResult) {
        guard let isConnected = SpotifyChannelState.appRemote?.isConnected else {
            result(unavailableSdkValueError("AppRemote.isConnected"))
            return
        }
        
        result(isConnected)
    }
    
    static func handle_connect_withCall(_ call: FlutterMethodCall, result: FlutterResult) {
        SpotifyChannelState.appRemote?.connect()
        result(true)
    }
    
    static func handle_disconnect_withCall(_ call: FlutterMethodCall, result: FlutterResult) {
        SpotifyChannelState.appRemote?.disconnect()
        result(true)
    }
    
    static func handle_authorizeAndPlayUri_withCall(_ call: FlutterMethodCall, result: FlutterResult) {
        guard let cocoaUri = call.arguments as? NSString else {
            result(argsErrorForCall(call))
            return
        }
        
        let uri = String(cocoaUri)
        
        SpotifyChannelState.appRemote!.authorizeAndPlayURI(uri)
        
        result(true)
    }
    
    static func handle_authorizationParametersFromURL_withCall(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let cocoaUrl = call.arguments as? NSString else {
            result(argsErrorForCall(call))
            return
        }
        
        guard let url = URL(string: cocoaUrl as String) else {
            result(valueCastError("cocoaUrl", expectedType: URL.self))
            return
        }
        
        SpotifyChannelState.appRemote?.authorizationParameters(from: url)
        
        result(true)
    }
}
