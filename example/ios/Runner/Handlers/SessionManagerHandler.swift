//
//  SessionManagerHandler.swift
//  Runner
//
//  Created by Juan Diego Fajardo on 7/15/19.
//  Copyright © 2019 The Chromium Authors. All rights reserved.
//

import Foundation

struct SessionManagerHandler {
    static func handle_isSpotifyAppInstalled_withCall(_ call: FlutterMethodCall, result: FlutterResult) {
        guard let isSpotifyAppInstalled = SpotifyChannelState.sessionManager?.isSpotifyAppInstalled else {
            result(unavailableSdkValueError("SessionManager.isSpotifyAppInstalled"))
            return
        }
        
        result(isSpotifyAppInstalled)
    }
    
    static func handle_initiateSessionWithScope_withCall(_ call: FlutterMethodCall, result: FlutterResult) {
        guard let args = call.arguments as? NSDictionary else {
            result(argsErrorForCall(call))
            return
        }
        
        guard let rawScope = args.object(forKey: Keys.SessionManager.scope) as? NSNumber else {
            result(keyCastError(Keys.SessionManager.scope, expectedType: NSNumber.self))
            return
        }
        
        guard let rawOptions = args.object(forKey: Keys.SessionManager.options) as? NSNumber else {
            result(keyCastError(Keys.SessionManager.options, expectedType: NSNumber.self))
            return
        }
        
        let scope = SPTScope(rawValue: rawScope.uintValue)
        let options = AuthorizationOptions(rawValue: rawOptions.uintValue)
        
        if #available(iOS 11.0, *) {
            SpotifyChannelState.sessionManager?.initiateSession(with: scope, options: options)
        } else {
            // Fallback on earlier versions
            guard let controller = SpotifyChannelState.controller else {
                result(result(unavailableSdkValueError("SpotifyChannelState.controller")))
                return
            }
            
            if #available(iOS 9.0, *) {
                SpotifyChannelState.sessionManager?.initiateSession(with: scope, options: options, presenting: controller)
            } else {
                // Fallback on unsupported versions
                result(customSdkErrorWithMessage("Version of iOS in use is not supported. Please use version iOS 11 or greater."))
            }
        }
        
        result(true)
    }
    
    static func handle_renewSession_withCall(_ call: FlutterMethodCall, result: FlutterResult) {
        SpotifyChannelState.sessionManager?.renewSession()
        result(true)
    }
    
    static func handle_session_withCall(_ call: FlutterMethodCall, result: FlutterResult) {
        guard let session = SpotifyChannelState.session else {
            result(unavailableSdkValueError("SessionManager.session"))
            return
        }
        
        // TODO: Encode session
        result(FlutterMethodNotImplemented)
    }
    
    static func handle_initializeSessionManager_withCall(_ call: FlutterMethodCall, result: FlutterResult) {
        guard let configurationObject = call.arguments as? NSDictionary else {
            result(argsErrorForCall(call))
            return
        }
        
        // TODO: Decode configurationObject
        let configuration: SPTConfiguration
        
        let sessionManager = SPTSessionManager(configuration: configuration, delegate: nil) // TODO: Delegate self
        
        // Set state
        SpotifyChannelState.sessionManager = sessionManager
        
        result(true)
    }
}
