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
        let rawContentType = call.arguments as! Int
        let contentType = contentTypeForRawValue(rawContentType)

        SpotifyChannelState.appRemote?.contentAPI?.fetchRootContentItems(forType: contentType, callback: { (sdkResult: Any?, error: Error?) in
            guard error == nil else {
                result(FlutterError(code: "SDK", message: error.debugDescription, details: nil))
                return
            }
            
            let contentItems: Array<SPTAppRemoteContentItem>? = sdkResult as? Array<SPTAppRemoteContentItem>
            if (contentItems != nil) {
                result(contentItems)
            } else {
                result(FlutterError(code: "CAST", message: "Could not cast sdkResult to desired type", details: nil))
            }
        })
    }
    
    static func handle_fetchChildrenOfContentItem_withCall(_ call: FlutterMethodCall, result: @escaping FlutterResult) {}
    
    static func handle_fetchRecommendedContentItemsForType_withCall(_ call: FlutterMethodCall, result: @escaping FlutterResult) {}
}

struct ImageApi {
    static func handle_fetchImageForItem_withCall(_ call: FlutterMethodCall, result: @escaping FlutterResult) {}
}

struct PlayerApi {
    static func handle_play_withCall(_ call: FlutterMethodCall, result: @escaping FlutterResult) {}
    
    static func handle_playItem_withCall(_ call: FlutterMethodCall, result: @escaping FlutterResult) {}
    
    static func handle_resume_withCall(_ call: FlutterMethodCall, result: @escaping FlutterResult) {}
    
    static func handle_pause_withCall(_ call: FlutterMethodCall, result: @escaping FlutterResult) {}
    
    static func handle_skipToNext_withCall(_ call: FlutterMethodCall, result: @escaping FlutterResult) {}
    
    static func handle_skipToPrevious_withCall(_ call: FlutterMethodCall, result: @escaping FlutterResult) {}
    
    static func handle_seekToPosition_withCall(_ call: FlutterMethodCall, result: @escaping FlutterResult) {}
    
    static func handle_seekForward15Seconds_withCall(_ call: FlutterMethodCall, result: @escaping FlutterResult) {}
    
    static func handle_seekBackward15Seconds_withCall(_ call: FlutterMethodCall, result: @escaping FlutterResult) {}
    
    static func handle_setShuffle_withCall(_ call: FlutterMethodCall, result: @escaping FlutterResult) {}
    
    static func handle_setRepeatMode_withCall(_ call: FlutterMethodCall, result: @escaping FlutterResult) {}
    
    static func handle_getPlayerState_withCall(_ call: FlutterMethodCall, result: @escaping FlutterResult) {}
    
    static func handle_subscribeToPlayerState_withCall(_ call: FlutterMethodCall, result: @escaping FlutterResult) {}
    
    static func handle_unsubscribeToPlayerState_withCall(_ call: FlutterMethodCall, result: @escaping FlutterResult) {}
    
    static func handle_enqueueTrackUri_withCall(_ call: FlutterMethodCall, result: @escaping FlutterResult) {}
    
    static func handle_getAvailablePodcastPlaybackSpeeds_withCall(_ call: FlutterMethodCall, result: @escaping FlutterResult) {}
    
    static func handle_getCurrentPodcastPlaybackSpeed_withCall(_ call: FlutterMethodCall, result: @escaping FlutterResult) {}
    
    static func handle_setPodcastPlaybackSpeed_withCall(_ call: FlutterMethodCall, result: @escaping FlutterResult) {}
    
    static func handle_getCrossfadeState_withCall(_ call: FlutterMethodCall, result: @escaping FlutterResult) {}
}

struct UserApi {
    static func handle_fetchCapabilities_withCall(_ call: FlutterMethodCall, result: @escaping FlutterResult) {}
    
    static func handle_subscribeToCapabilityChanges_withCall(_ call: FlutterMethodCall, result: @escaping FlutterResult) {}
    
    static func handle_unsubscribeToCapabilityChanges_withCall(_ call: FlutterMethodCall, result: @escaping FlutterResult) {}
    
    static func handle_fetchLibraryStateForUri_withCall(_ call: FlutterMethodCall, result: @escaping FlutterResult) {}
    
    static func handle_addUriToLibrary_withCall(_ call: FlutterMethodCall, result: @escaping FlutterResult) {}
    
    static func handle_removeUriFromLibrary_withCall(_ call: FlutterMethodCall, result: @escaping FlutterResult) {}
}

struct AppRemoteApi {
    static func handle_checkIfSpotifyAppIsActive_withCall(_ call: FlutterMethodCall, result: @escaping FlutterResult) {}
    
    static func handle_version_withCall(_ call: FlutterMethodCall, result: @escaping FlutterResult) {}
    
    static func handle_spotifyItunesItemIdentifier_withCall(_ call: FlutterMethodCall, result: @escaping FlutterResult) {}
    
    static func handle_initializeAppRemote_withCall(_ call: FlutterMethodCall, result: @escaping FlutterResult) {}
    
    static func handle_connectionParameters_withCall(_ call: FlutterMethodCall, result: @escaping FlutterResult) {}
    
    static func handle_isConnected_withCall(_ call: FlutterMethodCall, result: @escaping FlutterResult) {}
    
    static func handle_connect_withCall(_ call: FlutterMethodCall, result: @escaping FlutterResult) {}
    
    static func handle_disconnect_withCall(_ call: FlutterMethodCall, result: @escaping FlutterResult) {}
    
    static func handle_authorizeAndPlayUri_withCall(_ call: FlutterMethodCall, result: @escaping FlutterResult) {}
    
    static func handle_authorizationParametersFromURL_withCall(_ call: FlutterMethodCall, result: @escaping FlutterResult) {}
}

struct SessionApi {
    static func handle_isSpotifyAppInstalled_withCall(_ call: FlutterMethodCall, result: @escaping FlutterResult) {}
    
    static func handle_initiateSessionWithScope_withCall(_ call: FlutterMethodCall, result: @escaping FlutterResult) {}
    
    static func handle_renewSession_withCall(_ call: FlutterMethodCall, result: @escaping FlutterResult) {}
    
    static func handle_session_withCall(_ call: FlutterMethodCall, result: @escaping FlutterResult) {}
    
    static func handle_initializeSessionManager_withCall(_ call: FlutterMethodCall, result: @escaping FlutterResult) {}
}

private func contentTypeForRawValue(_ value: Int) -> String {
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
