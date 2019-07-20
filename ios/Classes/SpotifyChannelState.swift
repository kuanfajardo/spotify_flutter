//
//  SpotifyChannelState.swift
//  Pods-Runner
//
//  Created by Juan Diego Fajardo on 7/20/19.
//

import Foundation
import SpotifyiOS

public struct SpotifyChannelState {
    public static var appRemote: SPTAppRemote?
    public static var sessionManager: SPTSessionManager?
    
    public static var session: SPTSession? {
        get {
            return SpotifyChannelState.sessionManager?.session
        }
    }
    
    public static var controller: UIViewController?
}
