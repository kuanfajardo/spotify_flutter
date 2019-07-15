//
//  PlayerAPI.swift
//  Runner
//
//  Created by Juan Diego Fajardo on 7/15/19.
//  Copyright © 2019 The Chromium Authors. All rights reserved.
//

import Foundation

struct PlayerApiHandler {
    static func handle_play_withCall(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let cocoaEntityIdentifier = call.arguments as? NSString else {
            result(argsErrorForCall(call))
            return
        }
        
        let entityIdentifier = String(cocoaEntityIdentifier)
        
        SpotifyChannelState.appRemote?.playerAPI?.play(entityIdentifier) { (sdkResult: Any?, error: Error?) in
            guard error == nil else {
                result(sdkError(error!))
                return
            }
            
            // sdkResult is true if error is nil
            result(true)
        }
    }
    
    static func handle_playItem_withCall(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let args = call.arguments as? NSDictionary else {
            result(argsErrorForCall(call))
            return
        }
        
        guard let contentItemObject = args.object(forKey: Keys.PlayerApi.contentItem) as? NSDictionary else {
            result(keyCastError(Keys.PlayerApi.contentItem, expectedType: NSDictionary.self))
            return
        }
        
        let cocoaStartIndex: NSNumber? = args.object(forKey: Keys.PlayerApi.startIndex) as? NSNumber
        
        // TODO: Decode contentItemObject
        let contentItem: SPTAppRemoteContentItem
        
        if cocoaStartIndex != nil {
            guard let startIndex = Int(exactly: cocoaStartIndex!) else {
                result(valueCastError("cocoaStartIndex", expectedType: Int.self))
                return
            }
            
            SpotifyChannelState.appRemote?.playerAPI?.play(contentItem, skipToTrackIndex: startIndex) { (sdkResult: Any?, error: Error?) in
                guard error == nil else {
                    result(sdkError(error!))
                    return
                }
                
                // sdkResult is true if error is nil
                result(true)
            }
        } else {
            SpotifyChannelState.appRemote?.playerAPI?.play(contentItem) { (sdkResult: Any?, error: Error?) in
                guard error == nil else {
                    result(sdkError(error!))
                    return
                }
                
                // sdkResult is true if error is nil
                result(true)
            }
        }
    }
    
    static func handle_resume_withCall(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        SpotifyChannelState.appRemote?.playerAPI?.resume { (sdkResult: Any?, error: Error?) in
            guard error == nil else {
                result(sdkError(error!))
                return
            }
            
            // sdkResult is true if error is nil
            result(true)
        }
    }
    
    static func handle_pause_withCall(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        SpotifyChannelState.appRemote?.playerAPI?.pause { (sdkResult: Any?, error: Error?) in
            guard error == nil else {
                result(sdkError(error!))
                return
            }
            
            // sdkResult is true if error is nil
            result(true)
        }
    }
    
    static func handle_skipToNext_withCall(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        SpotifyChannelState.appRemote?.playerAPI?.skip(toNext: { (sdkResult: Any?, error: Error?) in
            guard error == nil else {
                result(sdkError(error!))
                return
            }
            
            // sdkResult is true if error is nil
            result(true)
        })
    }
    
    static func handle_skipToPrevious_withCall(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        SpotifyChannelState.appRemote?.playerAPI?.skip(toPrevious: { (sdkResult: Any?, error: Error?) in
            guard error == nil else {
                result(sdkError(error!))
                return
            }
            
            // sdkResult is true if error is nil
            result(true)
        })
    }
    
    static func handle_seekToPosition_withCall(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let cocoaPosition = call.arguments as? NSNumber else {
            result(argsErrorForCall(call))
            return
        }
        
        guard let position = Int(exactly: cocoaPosition) else {
            result(valueCastError("cocoaPosition", expectedType: Int.self))
            return
        }
        
        SpotifyChannelState.appRemote?.playerAPI?.seek(toPosition: position) { (sdkResult: Any?, error: Error?) in
            guard error == nil else {
                result(sdkError(error!))
                return
            }
            
            // sdkResult is true if error is nil
            result(true)
        }
    }
    
    static func handle_seekForward15Seconds_withCall(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        SpotifyChannelState.appRemote?.playerAPI?.seekForward15Seconds { (sdkResult: Any?, error: Error?) in
            guard error == nil else {
                result(sdkError(error!))
                return
            }
            
            // sdkResult is true if error is nil
            result(true)
        }
    }
    
    static func handle_seekBackward15Seconds_withCall(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        SpotifyChannelState.appRemote?.playerAPI?.seekBackward15Seconds { (sdkResult: Any?, error: Error?) in
            guard error == nil else {
                result(sdkError(error!))
                return
            }
            
            // sdkResult is true if error is nil
            result(true)
        }
    }
    
    static func handle_setShuffle_withCall(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let cocoaShuffle = call.arguments as? NSNumber else {
            result(argsErrorForCall(call))
            return
        }
        
        guard let shuffle = Bool(exactly: cocoaShuffle) else {
            result(valueCastError("cocoaShuffle", expectedType: Bool.self))
            return
        }
        
        SpotifyChannelState.appRemote?.playerAPI?.setShuffle(shuffle) { (sdkResult: Any?, error: Error?) in
            guard error == nil else {
                result(sdkError(error!))
                return
            }
            
            // sdkResult is true if error is nil
            result(true)
        }
    }
    
    static func handle_setRepeatMode_withCall(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let rawRepeatMode = call.arguments as? NSNumber else {
            result(argsErrorForCall(call))
            return
        }
        
        guard let repeatMode = SPTAppRemotePlaybackOptionsRepeatMode(rawValue: rawRepeatMode.uintValue) else {
            result(valueCastError("rawRepeatMode", expectedType: SPTAppRemotePlaybackOptionsRepeatMode.self))
            return
        }
        
        SpotifyChannelState.appRemote?.playerAPI?.setRepeatMode(repeatMode) { (sdkResult: Any?, error: Error?) in
            guard error == nil else {
                result(sdkError(error!))
                return
            }
            
            // sdkResult is true if error is nil
            result(true)
        }
    }
    
    static func handle_getPlayerState_withCall(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        SpotifyChannelState.appRemote?.playerAPI?.getPlayerState { (sdkResult: Any?, error: Error?) in
            guard error == nil else {
                result(sdkError(error!))
                return
            }
            
            guard let playerState = sdkResult as? SPTAppRemotePlayerState else {
                result(sdkResultUnpackingError(expectedType: SPTAppRemotePlayerState.self))
                return
            }
            
            // TODO: Encode playerState
            result(FlutterMethodNotImplemented)
        }
    }
    
    static func handle_subscribeToPlayerState_withCall(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        SpotifyChannelState.appRemote?.playerAPI?.subscribe(toPlayerState: { (sdkResult: Any?, error: Error?) in
            guard error == nil else {
                result(sdkError(error!))
                return
            }
            
            guard let playerState = sdkResult as? SPTAppRemotePlayerState else {
                result(sdkResultUnpackingError(expectedType: SPTAppRemotePlayerState.self))
                return
            }
            
            // TODO: Encode playerState
            result(FlutterMethodNotImplemented)
        })
    }
    
    static func handle_unsubscribeToPlayerState_withCall(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        SpotifyChannelState.appRemote?.playerAPI?.unsubscribe(toPlayerState: { (sdkResult: Any?, error: Error?) in
            guard error == nil else {
                result(sdkError(error!))
                return
            }
            
            // sdkResult is true if error is nil
            result(true)
        })
    }
    
    static func handle_enqueueTrackUri_withCall(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let cocoaTrackUri = call.arguments as? NSString else {
            result(argsErrorForCall(call))
            return
        }
        
        let trackUri = String(cocoaTrackUri)
        
        SpotifyChannelState.appRemote?.playerAPI?.enqueueTrackUri(trackUri) { (sdkResult: Any?, error: Error?) in
            guard error == nil else {
                result(sdkError(error!))
                return
            }
            
            // sdkResult is true if error is nil
            result(true)
        }
        
    }
    
    static func handle_getAvailablePodcastPlaybackSpeeds_withCall(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        SpotifyChannelState.appRemote?.playerAPI?.getAvailablePodcastPlaybackSpeeds { (sdkResult: Any?, error: Error?) in
            guard error == nil else {
                result(sdkError(error!))
                return
            }
            
            guard let availablePodcastPlaybackSpeeds = sdkResult as? Array<SPTAppRemotePodcastPlaybackSpeed> else {
                result(sdkResultUnpackingError(expectedType: Array<SPTAppRemotePodcastPlaybackSpeed>.self))
                return
            }
            
            // TODO: Encode availablePodcastPlaybackSpeeds
            result(FlutterMethodNotImplemented)
        }
    }
    
    static func handle_getCurrentPodcastPlaybackSpeed_withCall(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        SpotifyChannelState.appRemote?.playerAPI?.getCurrentPodcastPlaybackSpeed { (sdkResult: Any?, error: Error?) in
            guard error == nil else {
                result(sdkError(error!))
                return
            }
            
            guard let currentPodcastPlaybackSpeed = sdkResult as? SPTAppRemotePodcastPlaybackSpeed else {
                result(sdkResultUnpackingError(expectedType: SPTAppRemotePodcastPlaybackSpeed.self))
                return
            }
            
            // TODO: Encode currentPodcastPlaybackSpeed
            result(FlutterMethodNotImplemented)
        }
    }
    
    static func handle_setPodcastPlaybackSpeed_withCall(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let cocoaPlaybackSpeedObject = call.arguments as? NSDictionary else {
            result(argsErrorForCall(call))
            return
        }
        
        // TODO: Decode cocoaPlaybackSpeedObject
        let playbackSpeed: SPTAppRemotePodcastPlaybackSpeed
        
        SpotifyChannelState.appRemote?.playerAPI?.setPodcastPlaybackSpeed(playbackSpeed) { (sdkResult: Any?, error: Error?) in
            guard error == nil else {
                result(sdkError(error!))
                return
            }
            
            // sdkResult is true if error is nil
            result(true)
        }
    }
    
    static func handle_getCrossfadeState_withCall(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        SpotifyChannelState.appRemote?.playerAPI?.getCrossfadeState { (sdkResult: Any?, error: Error?) in
            guard error == nil else {
                result(sdkError(error!))
                return
            }
            
            guard let crossfadeState = sdkResult as? SPTAppRemoteCrossfadeState else {
                result(sdkResultUnpackingError(expectedType: SPTAppRemoteCrossfadeState.self))
                return
            }
            
            // TODO: Encode crossfadeState
            result(FlutterMethodNotImplemented)
        }
    }
}
