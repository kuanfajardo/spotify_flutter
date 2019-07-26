//
//  PlayerAPI.swift
//  Runner
//
//  Created by Juan Diego Fajardo on 7/15/19.
//  Copyright © 2019 The Chromium Authors. All rights reserved.
//

import Foundation
import SpotifyiOS

struct PlayerApiHandler {
    func handle(play call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let cocoaEntityIdentifier = call.arguments as? NSString else {
            result(argsErrorForCall(call))
            return
        }
        
        let entityIdentifier = String(cocoaEntityIdentifier)
        
        SwiftSpotifyPlugin.instance.appRemote?.playerAPI?.play(entityIdentifier) { (sdkResult: Any?, error: Error?) in
            guard error == nil else {
                result(sdkError(error!))
                return
            }
            
            // sdkResult is true if error is nil
            result(true)
        }
    }
    
    func handle(playItem call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let args = call.arguments as? NSDictionary else {
            result(argsErrorForCall(call))
            return
        }
        
        guard let contentItemObject = args.object(forKey: HandlerKeys.PlayerApi.contentItem) as? NSDictionary as? FlutterChannelObject else {
            result(keyCastError(HandlerKeys.PlayerApi.contentItem, expectedType: NSDictionary.self))
            return
        }
        
        let cocoaStartIndex: NSNumber? = args.object(forKey: HandlerKeys.PlayerApi.startIndex) as? NSNumber
        
        let contentItem = SpotifyContentItem(fromChannelObject: contentItemObject)
        
        if cocoaStartIndex != nil {
            guard let startIndex = Int(exactly: cocoaStartIndex!) else {
                result(valueCastError("cocoaStartIndex", expectedType: Int.self))
                return
            }
            
            SwiftSpotifyPlugin.instance.appRemote?.playerAPI?.play(contentItem, skipToTrackIndex: startIndex) { (sdkResult: Any?, error: Error?) in
                guard error == nil else {
                    result(sdkError(error!))
                    return
                }
                
                // sdkResult is true if error is nil
                result(true)
            }
        } else {
            SwiftSpotifyPlugin.instance.appRemote?.playerAPI?.play(contentItem) { (sdkResult: Any?, error: Error?) in
                guard error == nil else {
                    result(sdkError(error!))
                    return
                }
                
                // sdkResult is true if error is nil
                result(true)
            }
        }
    }
    
    func handle(resume call: FlutterMethodCall, result: @escaping FlutterResult) {
        SwiftSpotifyPlugin.instance.appRemote?.playerAPI?.resume { (sdkResult: Any?, error: Error?) in
            guard error == nil else {
                result(sdkError(error!))
                return
            }
            
            // sdkResult is true if error is nil
            result(true)
        }
    }
    
    func handle(pause call: FlutterMethodCall, result: @escaping FlutterResult) {
        SwiftSpotifyPlugin.instance.appRemote?.playerAPI?.pause { (sdkResult: Any?, error: Error?) in
            guard error == nil else {
                result(sdkError(error!))
                return
            }
            
            // sdkResult is true if error is nil
            result(true)
        }
    }
    
    func handle(skipToNext call: FlutterMethodCall, result: @escaping FlutterResult) {
        SwiftSpotifyPlugin.instance.appRemote?.playerAPI?.skip(toNext: { (sdkResult: Any?, error: Error?) in
            guard error == nil else {
                result(sdkError(error!))
                return
            }
            
            // sdkResult is true if error is nil
            result(true)
        })
    }
    
    func handle(skipToPrevious call: FlutterMethodCall, result: @escaping FlutterResult) {
        SwiftSpotifyPlugin.instance.appRemote?.playerAPI?.skip(toPrevious: { (sdkResult: Any?, error: Error?) in
            guard error == nil else {
                result(sdkError(error!))
                return
            }
            
            // sdkResult is true if error is nil
            result(true)
        })
    }
    
    func handle(seekToPosition call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let cocoaPosition = call.arguments as? NSNumber else {
            result(argsErrorForCall(call))
            return
        }
        
        guard let position = Int(exactly: cocoaPosition) else {
            result(valueCastError("cocoaPosition", expectedType: Int.self))
            return
        }
        
        SwiftSpotifyPlugin.instance.appRemote?.playerAPI?.seek(toPosition: position) { (sdkResult: Any?, error: Error?) in
            guard error == nil else {
                result(sdkError(error!))
                return
            }
            
            // sdkResult is true if error is nil
            result(true)
        }
    }
    
    func handle(seekForward15Seconds call: FlutterMethodCall, result: @escaping FlutterResult) {
        SwiftSpotifyPlugin.instance.appRemote?.playerAPI?.seekForward15Seconds { (sdkResult: Any?, error: Error?) in
            guard error == nil else {
                result(sdkError(error!))
                return
            }
            
            // sdkResult is true if error is nil
            result(true)
        }
    }
    
    func handle(seekBackward15Seconds call: FlutterMethodCall, result: @escaping FlutterResult) {
        SwiftSpotifyPlugin.instance.appRemote?.playerAPI?.seekBackward15Seconds { (sdkResult: Any?, error: Error?) in
            guard error == nil else {
                result(sdkError(error!))
                return
            }
            
            // sdkResult is true if error is nil
            result(true)
        }
    }
    
    func handle(setShuffle call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let cocoaShuffle = call.arguments as? NSNumber else {
            result(argsErrorForCall(call))
            return
        }
        
        guard let shuffle = Bool(exactly: cocoaShuffle) else {
            result(valueCastError("cocoaShuffle", expectedType: Bool.self))
            return
        }
        
        SwiftSpotifyPlugin.instance.appRemote?.playerAPI?.setShuffle(shuffle) { (sdkResult: Any?, error: Error?) in
            guard error == nil else {
                result(sdkError(error!))
                return
            }
            
            // sdkResult is true if error is nil
            result(true)
        }
    }
    
    func handle(setRepeatMode call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let rawRepeatMode = call.arguments as? NSNumber else {
            result(argsErrorForCall(call))
            return
        }
        
        guard let repeatMode = SPTAppRemotePlaybackOptionsRepeatMode(rawValue: rawRepeatMode.uintValue) else {
            result(valueCastError("rawRepeatMode", expectedType: SPTAppRemotePlaybackOptionsRepeatMode.self))
            return
        }
        
        SwiftSpotifyPlugin.instance.appRemote?.playerAPI?.setRepeatMode(repeatMode) { (sdkResult: Any?, error: Error?) in
            guard error == nil else {
                result(sdkError(error!))
                return
            }
            
            // sdkResult is true if error is nil
            result(true)
        }
    }
    
    func handle(getPlayerState call: FlutterMethodCall, result: @escaping FlutterResult) {
        SwiftSpotifyPlugin.instance.appRemote?.playerAPI?.getPlayerState { (sdkResult: Any?, error: Error?) in
            guard error == nil else {
                result(sdkError(error!))
                return
            }
            
            guard let playerState = sdkResult as? SPTAppRemotePlayerState else {
                result(sdkResultUnpackingError(expectedType: SPTAppRemotePlayerState.self))
                return
            }
            
            let encodedPlayerState = SpotifyPlayerState(fromSdkObject: playerState).encode()
            result(encodedPlayerState)
        }
    }
    
    func handle(subscribeToPlayerState call: FlutterMethodCall, result: @escaping FlutterResult) {
        SwiftSpotifyPlugin.instance.appRemote?.playerAPI?.subscribe(toPlayerState: { (sdkResult: Any?, error: Error?) in
            guard error == nil else {
                result(sdkError(error!))
                return
            }
            
            guard let playerState = sdkResult as? SPTAppRemotePlayerState else {
                result(sdkResultUnpackingError(expectedType: SPTAppRemotePlayerState.self))
                return
            }
            
            let encodedPlayerState = SpotifyPlayerState(fromSdkObject: playerState).encode()
            result(encodedPlayerState)
        })
    }
    
    func handle(unsubscribeToPlayerState call: FlutterMethodCall, result: @escaping FlutterResult) {
        SwiftSpotifyPlugin.instance.appRemote?.playerAPI?.unsubscribe(toPlayerState: { (sdkResult: Any?, error: Error?) in
            guard error == nil else {
                result(sdkError(error!))
                return
            }
            
            // sdkResult is true if error is nil
            result(true)
        })
    }
    
    func handle(enqueueTrackUri call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let cocoaTrackUri = call.arguments as? NSString else {
            result(argsErrorForCall(call))
            return
        }
        
        let trackUri = String(cocoaTrackUri)
        
        SwiftSpotifyPlugin.instance.appRemote?.playerAPI?.enqueueTrackUri(trackUri) { (sdkResult: Any?, error: Error?) in
            guard error == nil else {
                result(sdkError(error!))
                return
            }
            
            // sdkResult is true if error is nil
            result(true)
        }
        
    }
    
    func handle(getAvailablePodcastPlaybackSpeeds call: FlutterMethodCall, result: @escaping FlutterResult) {
        SwiftSpotifyPlugin.instance.appRemote?.playerAPI?.getAvailablePodcastPlaybackSpeeds { (sdkResult: Any?, error: Error?) in
            guard error == nil else {
                result(sdkError(error!))
                return
            }
            
            guard let availablePodcastPlaybackSpeeds = sdkResult as? Array<SPTAppRemotePodcastPlaybackSpeed> else {
                result(sdkResultUnpackingError(expectedType: Array<SPTAppRemotePodcastPlaybackSpeed>.self))
                return
            }
            
            var encodedAvailablePodcastPlaybackSpeeds = [SpotifyPodcastPlaybackSpeed]()
            availablePodcastPlaybackSpeeds.forEach({ (podcastPlaybackSpeed: SPTAppRemotePodcastPlaybackSpeed) in
                let concretePodcastPlaybackSpeed = SpotifyPodcastPlaybackSpeed(fromSdkObject: podcastPlaybackSpeed)
                encodedAvailablePodcastPlaybackSpeeds.append(concretePodcastPlaybackSpeed)
            })
            
            result(encodedAvailablePodcastPlaybackSpeeds)
        }
    }
    
    func handle(getCurrentPodcastPlaybackSpeed call: FlutterMethodCall, result: @escaping FlutterResult) {
        SwiftSpotifyPlugin.instance.appRemote?.playerAPI?.getCurrentPodcastPlaybackSpeed { (sdkResult: Any?, error: Error?) in
            guard error == nil else {
                result(sdkError(error!))
                return
            }
            
            guard let currentPodcastPlaybackSpeed = sdkResult as? SPTAppRemotePodcastPlaybackSpeed else {
                result(sdkResultUnpackingError(expectedType: SPTAppRemotePodcastPlaybackSpeed.self))
                return
            }
            
            let encodedCurrentPodcastPlaybackSpeed = SpotifyPodcastPlaybackSpeed(fromSdkObject: currentPodcastPlaybackSpeed).encode()
            result(encodedCurrentPodcastPlaybackSpeed)
        }
    }
    
    func handle(setPodcastPlaybackSpeed call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let playbackSpeedObject = call.arguments as? NSDictionary as? FlutterChannelObject else {
            result(argsErrorForCall(call))
            return
        }
        
        let playbackSpeed = SpotifyPodcastPlaybackSpeed(fromChannelObject: playbackSpeedObject)
        
        SwiftSpotifyPlugin.instance.appRemote?.playerAPI?.setPodcastPlaybackSpeed(playbackSpeed) { (sdkResult: Any?, error: Error?) in
            guard error == nil else {
                result(sdkError(error!))
                return
            }
            
            // sdkResult is true if error is nil
            result(true)
        }
    }
    
    func handle(getCrossfadeState call: FlutterMethodCall, result: @escaping FlutterResult) {
        SwiftSpotifyPlugin.instance.appRemote?.playerAPI?.getCrossfadeState { (sdkResult: Any?, error: Error?) in
            guard error == nil else {
                result(sdkError(error!))
                return
            }
            
            guard let crossfadeState = sdkResult as? SPTAppRemoteCrossfadeState else {
                result(sdkResultUnpackingError(expectedType: SPTAppRemoteCrossfadeState.self))
                return
            }
            
            let encodedCrossfateState = SpotifyCrossfadeState(fromSdkObject: crossfadeState).encode()
            result(encodedCrossfateState)
        }
    }
}
