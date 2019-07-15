//
//  Handlers.swift
//  Runner
//
//  Created by Juan Diego Fajardo on 7/13/19.
//  Copyright © 2019 The Chromium Authors. All rights reserved.
//

import Foundation

struct ContentApi {
    static func handle_fetchRootContentItemsForType_withCall(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let rawContentType = call.arguments as? NSNumber else {
            result(FlutterError(code: "ARGS", message: "Arguments are of wrong type.", details: nil))
            return
        }
        
        let contentType = contentTypeForRawValue(rawContentType)

        SpotifyChannelState.appRemote?.contentAPI?.fetchRootContentItems(forType: contentType) { (sdkResult: Any?, error: Error?) in
            guard error == nil else {
                result(FlutterError(code: "SDK", message: error.debugDescription, details: nil))
                return
            }
            
            guard let contentItems = sdkResult as? Array<SPTAppRemoteContentItem> else {
                result(FlutterError(code: "CAST", message: "Could not cast sdkResult to desired type", details: nil))
                return
            }
            
            // TODO: Codec contentItems
            result(FlutterMethodNotImplemented)
        }
    }
    
    static func handle_fetchChildrenOfContentItem_withCall(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let contentItemObject = call.arguments as? NSDictionary else {
            // TODO: ARGS ERROR
            return
        }
        
        // TODO: Decode contentItemObject
        let contentItem: SPTAppRemoteContentItem
        
        SpotifyChannelState.appRemote?.contentAPI?.fetchChildren(of: contentItem) { (sdkResult: Any?, error: Error?) in
            guard error == nil else {
                // TODO: SDK ERROR
                return
            }
            
            guard let children = sdkResult as? Array<SPTAppRemoteContentItem> else {
                // TODO: CAST ERROR
                return
            }
            
            // TODO: Codec children
            result(FlutterMethodNotImplemented)
        }
    }
    
    static func handle_fetchRecommendedContentItemsForType_withCall(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let args = call.arguments as? NSDictionary else {
            // TODO: ARGS ERROR
            return
        }
        
        guard let rawContentType = args.object(forKey: Keys.ContentApi.contentType) as? NSNumber else {
            // TODO: CAST ERROR
            return
        }
        
        guard let cocoaFlattenContainers = args.object(forKey: Keys.ContentApi.flattenContainers) as? NSNumber else {
            // TODO: CAST ERROR
            return
        }
        
        let contentType = contentTypeForRawValue(rawContentType)
        
        guard let flattenContainers = Bool(exactly: cocoaFlattenContainers) else {
            // TODO: CAST ERROR
            return
        }
        
        SpotifyChannelState.appRemote?.contentAPI?.fetchRecommendedContentItems(forType: contentType, flattenContainers: flattenContainers) { (sdkResult: Any?, error: Error?) in
            guard error == nil else {
                // TODO: SDK ERROR
                return
            }
            
            guard let contentItems = sdkResult as? Array<SPTAppRemoteContentItem> else {
                // TODO: CAST ERROR
                return
            }
            
            // TODO: Codec contentItems
            result(FlutterMethodNotImplemented)
        }
    }
}

struct ImageApi {
    static func handle_fetchImageForItem_withCall(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let args = call.arguments as? NSDictionary else {
            // TODO: ARGS ERROR
            return
        }
        
        guard let imageItemObject = args.object(forKey: Keys.ImageApi.imageItem) as? NSDictionary else {
            // TODO: CAST/ARGS ERROR
            return
        }
        
        guard let sizeObject = args.object(forKey: Keys.ImageApi.size) as? NSDictionary else {
            // TODO: CAST/ARGS ERROR
            return
        }
        
        // TODO: Decode imageItemObject
        let imageItem: SPTAppRemoteImageRepresentable
        
        // TODO: Decode sizeObject
        let size: CGSize
        
        SpotifyChannelState.appRemote?.imageAPI?.fetchImage(forItem: imageItem, with: size) { (sdkResult: Any?, error: Error?) in
            guard error == nil else {
                // TODO: SDK ERROR
                return
            }
            
            guard let image = sdkResult as? UIImage else {
                // TODO: CAST ERROR
                return
            }
            
            // TODO: Codec image
            result(FlutterMethodNotImplemented)
        }
    }
}

struct PlayerApi {
    static func handle_play_withCall(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let cocoaEntityIdentifier = call.arguments as? NSString else {
            // TODO: ARGS ERROR
            return
        }
        
        let entityIdentifier = String(cocoaEntityIdentifier)

        SpotifyChannelState.appRemote?.playerAPI?.play(entityIdentifier) { (sdkResult: Any?, error: Error?) in
            guard error == nil else {
                // TODO: SDK ERROR
                return
            }
            
            // sdkResult is true if error is nil
            result(true)
        }
    }
    
    static func handle_playItem_withCall(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let args = call.arguments as? NSDictionary else {
            // TODO: ARGS ERROR
            return
        }
        
        guard let contentItemObject = args.object(forKey: Keys.PlayerApi.contentItem) as? NSDictionary else {
            // TODO: ARGS/CAST ERROR
            return
        }
        
        let cocoaStartIndex: NSNumber? = args.object(forKey: Keys.PlayerApi.startIndex) as? NSNumber
        
        // TODO: Decode contentItemObject
        let contentItem: SPTAppRemoteContentItem
    
        if cocoaStartIndex != nil {
            guard let startIndex = Int(exactly: cocoaStartIndex!) else {
                // TODO: CAST ERROR
                return
            }
            
            SpotifyChannelState.appRemote?.playerAPI?.play(contentItem, skipToTrackIndex: startIndex) { (sdkResult: Any?, error: Error?) in
                guard error == nil else {
                    // TODO: SDK ERROR
                    return
                }
                
                // sdkResult is true if error is nil
                result(true)
            }
        } else {
            SpotifyChannelState.appRemote?.playerAPI?.play(contentItem) { (sdkResult: Any?, error: Error?) in
                guard error == nil else {
                    // TODO: SDK ERROR
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
                // TODO: SDK ERROR
                return
            }
            
            // sdkResult is true if error is nil
            result(true)
        }
    }
    
    static func handle_pause_withCall(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        SpotifyChannelState.appRemote?.playerAPI?.pause { (sdkResult: Any?, error: Error?) in
            guard error == nil else {
                // TODO: SDK ERROR
                return
            }
            
            // sdkResult is true if error is nil
            result(true)
        }
    }
    
    static func handle_skipToNext_withCall(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        SpotifyChannelState.appRemote?.playerAPI?.skip(toNext: { (sdkResult: Any?, error: Error?) in
            guard error == nil else {
                // TODO: SDK ERROR
                return
            }
            
            // sdkResult is true if error is nil
            result(true)
        })
    }
    
    static func handle_skipToPrevious_withCall(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        SpotifyChannelState.appRemote?.playerAPI?.skip(toPrevious: { (sdkResult: Any?, error: Error?) in
            guard error == nil else {
                // TODO: SDK ERROR
                return
            }
            
            // sdkResult is true if error is nil
            result(true)
        })
    }
    
    static func handle_seekToPosition_withCall(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let cocoaPosition = call.arguments as? NSNumber else {
            // TODO: ARGS ERROR
            return
        }
        
        guard let position = Int(exactly: cocoaPosition) else {
            // TODO: CAST ERROR
            return
        }
        
        SpotifyChannelState.appRemote?.playerAPI?.seek(toPosition: position) { (sdkResult: Any?, error: Error?) in
            guard error == nil else {
                // TODO: SDK ERROR
                return
            }
            
            // sdkResult is true if error is nil
            result(true)
        }
    }
    
    static func handle_seekForward15Seconds_withCall(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        SpotifyChannelState.appRemote?.playerAPI?.seekForward15Seconds { (sdkResult: Any?, error: Error?) in
            guard error == nil else {
                // TODO: SDK ERROR
                return
            }
            
            // sdkResult is true if error is nil
            result(true)
        }
    }
    
    static func handle_seekBackward15Seconds_withCall(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        SpotifyChannelState.appRemote?.playerAPI?.seekBackward15Seconds { (sdkResult: Any?, error: Error?) in
            guard error == nil else {
                // TODO: SDK ERROR
                return
            }
            
            // sdkResult is true if error is nil
            result(true)
        }
    }
    
    static func handle_setShuffle_withCall(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let shuffleAsNumber = call.arguments as? NSNumber else {
            // TODO: ARGS ERROR
            return
        }
        
        guard let shuffle = Bool(exactly: shuffleAsNumber) else {
            // TODO: CAST ERROR
            return
        }
        
        SpotifyChannelState.appRemote?.playerAPI?.setShuffle(shuffle) { (sdkResult: Any?, error: Error?) in
            guard error == nil else {
                // TODO: SDK ERROR
                return
            }
            
            // sdkResult is true if error is nil
            result(true)
        }
    }
    
    static func handle_setRepeatMode_withCall(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let rawRepeatMode = call.arguments as? NSNumber else {
            // TODO: ARGS ERROR
            return
        }
        
        guard let repeatMode = SPTAppRemotePlaybackOptionsRepeatMode(rawValue: rawRepeatMode.uintValue) else {
            // TODO: ARGS / CAST ERROR
            return
        }
        
        SpotifyChannelState.appRemote?.playerAPI?.setRepeatMode(repeatMode) { (sdkResult: Any?, error: Error?) in
            guard error == nil else {
                // TODO: SDK ERROR
                return
            }
            
            // sdkResult is true if error is nil
            result(true)
        }
    }
    
    static func handle_getPlayerState_withCall(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        SpotifyChannelState.appRemote?.playerAPI?.getPlayerState { (sdkResult: Any?, error: Error?) in
            guard error == nil else {
                // TODO: SDK ERROR
                return
            }
            
            guard let playerState = sdkResult as? SPTAppRemotePlayerState else {
                // TODO: CAST ERROR
                return
            }
            
            // TODO: Codec playerState
            result(FlutterMethodNotImplemented)
        }
    }
    
    static func handle_subscribeToPlayerState_withCall(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        SpotifyChannelState.appRemote?.playerAPI?.subscribe(toPlayerState: { (sdkResult: Any?, error: Error?) in
            guard error == nil else {
                // TODO: SDK ERROR
                return
            }
            
            guard let playerState = sdkResult as? SPTAppRemotePlayerState else {
                // TODO: CAST ERROR
                return
            }
            
            // TODO: Codec playerState
            result(FlutterMethodNotImplemented)
        })
    }
    
    static func handle_unsubscribeToPlayerState_withCall(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        SpotifyChannelState.appRemote?.playerAPI?.unsubscribe(toPlayerState: { (sdkResult: Any?, error: Error?) in
            guard error == nil else {
                // TODO: SDK ERROR
                return
            }
            
            // sdkResult is true if error is nil
            result(true)
        })
    }
    
    static func handle_enqueueTrackUri_withCall(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let cocoaTrackUri = call.arguments as? NSString else {
            // TODO: ARGS ERROR
            return
        }
        
        let trackUri = String(cocoaTrackUri)
        
        SpotifyChannelState.appRemote?.playerAPI?.enqueueTrackUri(trackUri) { (sdkResult: Any?, error: Error?) in
            guard error == nil else {
                // TODO: SDK ERROR
                return
            }
            
            // sdkResult is true if error is nil
            result(true)
        }

    }
    
    static func handle_getAvailablePodcastPlaybackSpeeds_withCall(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        SpotifyChannelState.appRemote?.playerAPI?.getAvailablePodcastPlaybackSpeeds { (sdkResult: Any?, error: Error?) in
            guard error == nil else {
                // TODO: SDK ERROR
                return
            }
            
            guard let cocoaAvailablePodcastPlaybackSpeeds = sdkResult as? NSArray else {
                // TODO: CAST ERROR
                return
            }
            
            guard let availablePodcastPlaybackSpeeds = cocoaAvailablePodcastPlaybackSpeeds as? Array<SPTAppRemotePodcastPlaybackSpeed> else {
                // TODO: CAST ERROR
                return
            }
            
            // TODO: Codec availablePodcastPlaybackSpeeds
            result(FlutterMethodNotImplemented)
        }
    }
    
    static func handle_getCurrentPodcastPlaybackSpeed_withCall(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        SpotifyChannelState.appRemote?.playerAPI?.getCurrentPodcastPlaybackSpeed { (sdkResult: Any?, error: Error?) in
            guard error == nil else {
                // TODO: SDK ERROR
                return
            }
            
            guard let currentPodcastPlaybackSpeed = sdkResult as? SPTAppRemotePodcastPlaybackSpeed else {
                // TODO: CAST ERROR
                return
            }
            
            // TODO: Codec currentPodcastPlaybackSpeed
            result(FlutterMethodNotImplemented)
        }
    }
    
    static func handle_setPodcastPlaybackSpeed_withCall(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let cocoaPlaybackSpeedObject = call.arguments as? NSDictionary else {
            // TODO: ARGS ERROR
            return
        }
        
        // TODO: Decode cocoaPlaybackSpeedObject
        let playbackSpeed: SPTAppRemotePodcastPlaybackSpeed
        
        SpotifyChannelState.appRemote?.playerAPI?.setPodcastPlaybackSpeed(playbackSpeed) { (sdkResult: Any?, error: Error?) in
            guard error == nil else {
                // TODO: SDK ERROR
                return
            }
            
            // sdkResult is true if error is nil
            result(true)
        }
    }
    
    static func handle_getCrossfadeState_withCall(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        SpotifyChannelState.appRemote?.playerAPI?.getCrossfadeState { (sdkResult: Any?, error: Error?) in
            guard error == nil else {
                // TODO: SDK ERROR
                return
            }
            
            guard let crossfadeState = sdkResult as? SPTAppRemoteCrossfadeState else {
                // TODO: CAST ERROR
                return
            }
            
            // TODO: Codec crossfadeState
            result(FlutterMethodNotImplemented)
        }
    }
}

struct UserApi {
    static func handle_fetchCapabilities_withCall(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        SpotifyChannelState.appRemote?.userAPI?.fetchCapabilities { (sdkResult: Any?, error: Error?) in
            guard error == nil else {
                // TODO: SDK ERROR
                return
            }
            
            guard let capabilities = sdkResult as? SPTAppRemoteUserCapabilities else {
                // TODO: CAST ERROR
                return
            }
            
            // Codec capabilities
            result(FlutterMethodNotImplemented)
        }
    }
    
    static func handle_subscribeToCapabilityChanges_withCall(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        SpotifyChannelState.appRemote?.userAPI?.subscribe(toCapabilityChanges: { (sdkResult: Any?, error: Error?) in
            guard error == nil else {
                // TODO: SDK ERROR
                return
            }
            
            // sdkResult is true if error is nil
            result(true)
        })
    }
    
    static func handle_unsubscribeToCapabilityChanges_withCall(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        SpotifyChannelState.appRemote?.userAPI?.unsubscribe(toCapabilityChanges: { (sdkResult: Any?, error: Error?) in
            guard error == nil else {
                // TODO: SDK ERROR
                return
            }
            
            // sdkResult is true if error is nil
            result(true)
        })
    }
    
    static func handle_fetchLibraryStateForUri_withCall(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let cocoaUri = call.arguments as? NSString else {
            // TODO: ARGS ERROR
            return
        }
        
        let uri = String(cocoaUri)
        
        SpotifyChannelState.appRemote?.userAPI?.fetchLibraryState(forURI: uri) { (sdkResult: Any?, error: Error?) in
            guard error == nil else {
                // TODO: SDK ERROR
                return
            }
            
            guard let libraryState = sdkResult as? SPTAppRemoteLibraryState else {
                // TODO: CAST ERROR
                return
            }
            
            // TODO: Codec libraryState
            result(FlutterMethodNotImplemented)
        }
    }
    
    static func handle_addUriToLibrary_withCall(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let cocoaUri = call.arguments as? NSString else {
            // TODO: ARGS ERROR
            return
        }
        
        let uri = String(cocoaUri)
        
        SpotifyChannelState.appRemote?.userAPI?.addItemToLibrary(withURI: uri) { (sdkResult: Any?, error: Error?) in
            guard error == nil else {
                // TODO: SDK ERROR
                return
            }
            
            // sdkResult is true if error is nil
            result(true)
        }
    }
    
    static func handle_removeUriFromLibrary_withCall(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let cocoaUri = call.arguments as? NSString else {
            // TODO: ARGS ERROR
            return
        }
        
        let uri = String(cocoaUri)
        
        SpotifyChannelState.appRemote?.userAPI?.removeItemFromLibrary(withURI: uri) { (sdkResult: Any?, error: Error?) in
            guard error == nil else {
                // TODO: SDK ERROR
                return
            }
            
            // sdkResult is true if error is nil
            result(true)
        }
    }
}

struct AppRemoteApi {
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
            // TODO: ARGS ERROR
            return
        }
        
        guard let configurationObject = args.object(forKey: Keys.AppRemote.configuration) as? NSDictionary else {
            // TODO: CAST/ARGS ERROR
            return
        }
        
        guard let rawLogLevel = args.object(forKey: Keys.AppRemote.logLevel) as? NSNumber else {
            // TODO: CAST/ARGS ERROR
            return
        }
        
        let connectionParamsObject = args.object(forKey: Keys.AppRemote.connectionParams) as? NSDictionary
        
        // TODO: Decode configurationObject
        let configuration: SPTConfiguration
        
        guard let logLevel = SPTAppRemoteLogLevel(rawValue: rawLogLevel.uintValue) else {
            // TODO: CAST ERROR
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
            // TODO: SDK ERROR
            return
        }
        
        // TODO: Decode connectionParams
        result(FlutterMethodNotImplemented)
    }
    
    static func handle_isConnected_withCall(_ call: FlutterMethodCall, result: FlutterResult) {
        guard let isConnected = SpotifyChannelState.appRemote?.isConnected else {
            // TODO: SDK ERROR
            return
        }
        
        // TODO: Decode isConnected
        result(FlutterMethodNotImplemented)
    }
    
    static func handle_connect_withCall(_ call: FlutterMethodCall, result: FlutterResult) {
        SpotifyChannelState.appRemote?.connect()
        result(true)
    }
    
    static func handle_disconnect_withCall(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        SpotifyChannelState.appRemote?.disconnect()
        result(true)
    }
    
    static func handle_authorizeAndPlayUri_withCall(_ call: FlutterMethodCall, result: FlutterResult) {
        guard let cocoaUri = call.arguments as? NSString else {
            // TODO: ARGS ERROR
            return
        }
        
        let uri = String(cocoaUri)
        
        SpotifyChannelState.appRemote!.authorizeAndPlayURI(uri)
        
        result(true)
    }
    
    static func handle_authorizationParametersFromURL_withCall(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let cocoaUrl = call.arguments as? NSString else {
            // TODO: ARGS ERROR
            return
        }
        
        guard let url = URL(string: cocoaUrl as String) else {
            // TODO: CAST ERROR
            return
        }
        
        SpotifyChannelState.appRemote?.authorizationParameters(from: url)
        
        result(true)
    }
}

struct SessionManagerApi {
    static func handle_isSpotifyAppInstalled_withCall(_ call: FlutterMethodCall, result: FlutterResult) {
        guard let isSpotifyAppInstalled = SpotifyChannelState.sessionManager?.isSpotifyAppInstalled else {
            // TODO: SDK ERROR
            return
        }
        
        result(isSpotifyAppInstalled)
    }
    
    static func handle_initiateSessionWithScope_withCall(_ call: FlutterMethodCall, result: FlutterResult) {
        guard let args = call.arguments as? NSDictionary else {
            // TODO: ARGS ERROR
            return
        }
        
        guard let rawScope = args.object(forKey: Keys.SessionManager.scope) as? NSNumber else {
            // TODO: CAST ERROR
            return
        }
        
        guard let rawOptions = args.object(forKey: Keys.SessionManager.options) as? NSNumber else {
            // TODO: CAST ERROR
            return
        }
        
        let scope = SPTScope(rawValue: rawScope.uintValue)
        let options = AuthorizationOptions(rawValue: rawOptions.uintValue)
        
        if #available(iOS 11.0, *) {
            SpotifyChannelState.sessionManager?.initiateSession(with: scope, options: options)
        } else {
            // Fallback on earlier versions
            guard let controller = SpotifyChannelState.controller else {
                // TODO: ERROR
                return
            }
            
            if #available(iOS 9.0, *) {
                SpotifyChannelState.sessionManager?.initiateSession(with: scope, options: options, presenting: controller)
            } else {
                // Fallback on unsupported versions
                // TODO: SDK ERROR
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
            // TODO: SDK ERROR
            return
        }
        
        // TODO: Codec session
        result(FlutterMethodNotImplemented)
    }
    
    static func handle_initializeSessionManager_withCall(_ call: FlutterMethodCall, result: FlutterResult) {
        guard let configurationObject = call.arguments as? NSDictionary else {
            // TODO: ARGS ERROR
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

private func contentTypeForRawValue(_ value: NSNumber) -> String {
    switch value {
    case 0:
        return SPTAppRemoteContentTypeDefault
    case 1:
        return SPTAppRemoteContentTypeNavigation
    case 2:
        return SPTAppRemoteContentTypeFitness
    default:
        return SPTAppRemoteContentTypeDefault
    }
}

