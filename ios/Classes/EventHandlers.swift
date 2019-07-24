//
//  EventHandlers.swift
//  Pods-Runner
//
//  Created by Juan Diego Fajardo on 7/24/19.
//

import Foundation
import Flutter

public class AppRemoteDelegateStreamHandler: NSObject, FlutterStreamHandler {
    public func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        SwiftSpotifyPlugin.appRemoteEventSink = events
        return nil
    }
    
    public func onCancel(withArguments arguments: Any?) -> FlutterError? {
        SwiftSpotifyPlugin.appRemoteEventSink = nil
        return nil
    }
}

public class SessionManagerDelegateStreamHandler: NSObject, FlutterStreamHandler {
    public func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        SwiftSpotifyPlugin.sessionManagerEventSink = events
        return nil
    }
    
    public func onCancel(withArguments arguments: Any?) -> FlutterError? {
        SwiftSpotifyPlugin.sessionManagerEventSink = nil
        return nil
    }
}

public class PlayerStateStreamHandler: NSObject, FlutterStreamHandler {
    public func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        SwiftSpotifyPlugin.playerStateEventSink = events
        return nil
    }
    
    public func onCancel(withArguments arguments: Any?) -> FlutterError? {
        SwiftSpotifyPlugin.playerStateEventSink = nil
        return nil
    }
}

public class UserCapabilitiesStreamHandler: NSObject, FlutterStreamHandler {
    public func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        SwiftSpotifyPlugin.userCapabilitiesEventSink = events
        return nil
    }
    
    public func onCancel(withArguments arguments: Any?) -> FlutterError? {
        SwiftSpotifyPlugin.userCapabilitiesEventSink = nil
        return nil
    }
}
