//
//  SessionManagerHandler.swift
//  Runner
//
//  Created by Juan Diego Fajardo on 7/15/19.
//  Copyright © 2019 The Chromium Authors. All rights reserved.
//

import Foundation
import SpotifyiOS

struct SessionManagerHandler {
    func handle(isSpotifyAppInstalled call: FlutterMethodCall, result: FlutterResult) {
        guard let isSpotifyAppInstalled = SwiftSpotifyPlugin.instance.sessionManager?.isSpotifyAppInstalled else {
            result(unavailableSdkValueError("SessionManager.isSpotifyAppInstalled"))
            return
        }
        
        result(isSpotifyAppInstalled)
    }
    
    func handle(initiateSessionWithScope call: FlutterMethodCall, result: FlutterResult) {
        guard let args = call.arguments as? NSDictionary else {
            result(argsErrorForCall(call))
            return
        }
        
        guard let scopeObject = args.object(forKey: HandlerKeys.SessionManager.scope) as? NSDictionary as? CodecResult else {
            result(keyCastError(HandlerKeys.SessionManager.scope, expectedType: NSNumber.self))
            return
        }
        
        guard let rawOptions = args.object(forKey: HandlerKeys.SessionManager.options) as? NSNumber else {
            result(keyCastError(HandlerKeys.SessionManager.options, expectedType: NSNumber.self))
            return
        }
        
        let scope = scopeFromCodecObject(scopeObject)
        let options = AuthorizationOptions(rawValue: rawOptions.uintValue)
        
        if #available(iOS 11.0, *) {
            SwiftSpotifyPlugin.instance.sessionManager?.initiateSession(with: scope, options: options)
        } else {
            // Fallback on earlier versions
            guard let controller = SwiftSpotifyPlugin.instance.controller else {
                result(result(unavailableSdkValueError("SwiftSpotifyPlugin.instance.controller")))
                return
            }
            
            if #available(iOS 9.0, *) {
                SwiftSpotifyPlugin.instance.sessionManager?.initiateSession(with: scope, options: options, presenting: controller)
            } else {
                // Fallback on unsupported versions
                result(customSdkErrorWithMessage("Version of iOS in use is not supported. Please use version iOS 11 or greater."))
            }
        }
        
        result(true)
    }
    
    func handle(renewSession call: FlutterMethodCall, result: FlutterResult) {
        SwiftSpotifyPlugin.instance.sessionManager?.renewSession()
        result(true)
    }
    
    func handle(session call: FlutterMethodCall, result: FlutterResult) {
        guard let session = SwiftSpotifyPlugin.instance.sessionManager?.session else {
            result(unavailableSdkValueError("SessionManager.session"))
            return
        }
        
        let encodedSession = session.encode()
        result(encodedSession)
    }
    
    func handle(initializeSessionManager call: FlutterMethodCall, result: FlutterResult) {
        guard let configurationObject = call.arguments as? NSDictionary as? CodecResult else {
            result(argsErrorForCall(call))
            return
        }
        
        let configuration = SPTConfiguration.configurationFromCodecObject(configurationObject)
        
        let sessionManager = SPTSessionManager(configuration: configuration, delegate: SwiftSpotifyPlugin.instance)
        
        // Set state
        SwiftSpotifyPlugin.instance.sessionManager = sessionManager
        
        result(true)
    }
}

private func scopeFromCodecObject(_ codecResult: CodecResult) -> SPTScope {
    let extractor = CodecResultExtractor(codecResult)
    let bitmask: Int = extractor.get(CodecKeys.Scope.bitmask)!
    return SPTScope(rawValue: UInt(bitmask))
}
