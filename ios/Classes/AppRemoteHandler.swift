//
//  AppRemoteHandler.swift
//  Runner
//
//  Created by Juan Diego Fajardo on 7/15/19.
//  Copyright © 2019 The Chromium Authors. All rights reserved.
//

import Foundation
import SpotifyiOS

struct AppRemoteHandler {
    func handle_checkIfSpotifyAppIsActive_withCall(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        SPTAppRemote.checkIfSpotifyAppIsActive { (isActive: Bool) in
            result(isActive)
        }
    }
    
    func handle_version_withCall(_ call: FlutterMethodCall, result: FlutterResult) {
        let version = SPTAppRemote.version()
        result(version)
    }
    
    func handle_spotifyItunesItemIdentifier_withCall(_ call: FlutterMethodCall, result: FlutterResult) {
        let itunesItemIdentifier: NSNumber = SPTAppRemote.spotifyItunesItemIdentifier()
        result(itunesItemIdentifier)
    }
    
    func handle_initializeAppRemote_withCall(_ call: FlutterMethodCall, result: FlutterResult) {
        guard let args = call.arguments as? NSDictionary else {
            result(argsErrorForCall(call))
            return
        }
        
        guard let configurationObject = args.object(forKey: HandlerKeys.AppRemote.configuration) as? NSDictionary as? CodecResult else {
            result(keyCastError(HandlerKeys.AppRemote.configuration, expectedType: NSDictionary.self))
            return
        }
        
        guard let rawLogLevel = args.object(forKey: HandlerKeys.AppRemote.logLevel) as? NSNumber else {
            result(keyCastError(HandlerKeys.AppRemote.logLevel, expectedType: NSNumber.self))
            return
        }
        
        let connectionParamsObject = args.object(forKey: HandlerKeys.AppRemote.connectionParams) as? NSDictionary as? CodecResult
        
        let configuration = SPTConfiguration.configurationFromCodecObject(configurationObject)
        
        guard let logLevel = SPTAppRemoteLogLevel(rawValue: rawLogLevel.uintValue) else {
            result(valueCastError("rawLogLevel", expectedType: SPTAppRemoteLogLevel.self))
            return
        }
        
        let connectionParams = SPTAppRemoteConnectionParams.connectionParamsFromCodecObject(connectionParamsObject)
        
        let appRemote: SPTAppRemote
        
        if connectionParams != nil {
            appRemote = SPTAppRemote(configuration: configuration, connectionParameters: connectionParams!, logLevel: logLevel)
        } else {
            appRemote = SPTAppRemote(configuration: configuration, logLevel: logLevel)
        }
        
        // Set state
        SwiftSpotifyPlugin.instance.appRemote = appRemote
        appRemote.delegate = SwiftSpotifyPlugin.instance;
        
        // TODO: Return connection params
        result(true)
    }
    
    func handle_connectionParameters_withCall(_ call: FlutterMethodCall, result: FlutterResult) {
        guard let connectionParams = SwiftSpotifyPlugin.instance.appRemote?.connectionParameters else {
            result(unavailableSdkValueError("AppRemote.connectionParameters"))
            return
        }
        
        let encodedConnectionParams = connectionParams.encode()
        result(encodedConnectionParams)
    }
    
    func handle_isConnected_withCall(_ call: FlutterMethodCall, result: FlutterResult) {
        guard let isConnected = SwiftSpotifyPlugin.instance.appRemote?.isConnected else {
            result(unavailableSdkValueError("AppRemote.isConnected"))
            return
        }
        
        result(isConnected)
    }
    
    func handle_connect_withCall(_ call: FlutterMethodCall, result: FlutterResult) {
        SwiftSpotifyPlugin.instance.appRemote?.connect()
        result(true)
    }
    
    func handle_disconnect_withCall(_ call: FlutterMethodCall, result: FlutterResult) {
        SwiftSpotifyPlugin.instance.appRemote?.disconnect()
        result(true)
    }
    
    func handle_authorizeAndPlayUri_withCall(_ call: FlutterMethodCall, result: FlutterResult) {
        guard let cocoaUri = call.arguments as? NSString else {
            result(argsErrorForCall(call))
            return
        }
        
        let uri = String(cocoaUri)
        
        SwiftSpotifyPlugin.instance.appRemote?.authorizeAndPlayURI(uri)
        
        result(true)
    }
    
    func handle_authorizationParametersFromURL_withCall(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let cocoaUrl = call.arguments as? NSString else {
            result(argsErrorForCall(call))
            return
        }
        
        guard let url = URL(string: cocoaUrl as String) else {
            result(valueCastError("cocoaUrl", expectedType: URL.self))
            return
        }
        
        SwiftSpotifyPlugin.instance.appRemote?.authorizationParameters(from: url)
        
        result(true)
    }
}
