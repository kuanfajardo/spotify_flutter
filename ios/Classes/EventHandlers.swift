//
//  EventHandlers.swift
//  Pods-Runner
//
//  Created by Juan Diego Fajardo on 7/24/19.
//

import Foundation
import Flutter

class AppRemoteDelegateStreamHandler: NSObject, FlutterStreamHandler {
    public func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        SwiftSpotifyPlugin.instance.appRemoteEventSink = events
        return nil
    }
    
    public func onCancel(withArguments arguments: Any?) -> FlutterError? {
        SwiftSpotifyPlugin.instance.appRemoteEventSink = nil
        return nil
    }
}

class SessionManagerDelegateStreamHandler: NSObject, FlutterStreamHandler {
    func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        SwiftSpotifyPlugin.instance.sessionManagerEventSink = events
        return nil
    }
    
    func onCancel(withArguments arguments: Any?) -> FlutterError? {
        SwiftSpotifyPlugin.instance.sessionManagerEventSink = nil
        return nil
    }
}

class PlayerStateStreamHandler: NSObject, FlutterStreamHandler {
    func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        SwiftSpotifyPlugin.instance.playerStateEventSink = events
        return nil
    }
    
    func onCancel(withArguments arguments: Any?) -> FlutterError? {
        SwiftSpotifyPlugin.instance.playerStateEventSink = nil
        return nil
    }
}

class UserCapabilitiesStreamHandler: NSObject, FlutterStreamHandler {
    func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        SwiftSpotifyPlugin.instance.userCapabilitiesEventSink = events
        return nil
    }
    
    func onCancel(withArguments arguments: Any?) -> FlutterError? {
        SwiftSpotifyPlugin.instance.userCapabilitiesEventSink = nil
        return nil
    }
}
