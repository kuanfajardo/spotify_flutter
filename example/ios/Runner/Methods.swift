//
//  Methods.swift
//  Runner
//
//  Created by Juan Diego Fajardo on 7/13/19.
//  Copyright © 2019 The Chromium Authors. All rights reserved.
//

import Foundation

struct Methods {
    struct ContentApi {
        static let fetchRootContentItemsForType = "contentApi_fetchRootContentItemsForType"
        static let fetchChildrenOfContentItem = "contentApi_fetchChildrenOfContentItem"
        static let fetchRecommendedContentItemsForType = "contentApi_fetchRecommendedContentItemsForType"
    }
    
    struct ImageApi {
        static let fetchImageForItem = "imageApi_fetchImageForItem"
    }
    
    struct PlayerApi {
        static let play = "playerApi_play";
        static let playItem = "playerApi_playItem";
        static let resume = "playerApi_resume";
        static let pause = "playerApi_pause";
        static let skipToPrevious = "playerApi_skipToPrevious";
        static let skipToNext = "playerApi_skipToNext";
        static let seekToPosition = "playerApi_seekToPosition";
        static let seekForward15Seconds = "playerApi_seekForward15Seconds";
        static let seekBackward15Seconds = "playerApi_seekBackward15Seconds";
        static let setShuffle = "playerApi_setShuffle";
        static let setRepeatMode = "playerApi_setRepeatMode";
        static let getPlayerState = "playerApi_getPlayerState";
        static let subscribeToPlayerState = "playerApi_subscribeToPlayerState";
        static let unsubscribeToPlayerState = "playerApi_unsubscribeToPlayerState";
        static let enqueueTrackUri = "playerApi_enqueueTrackUri";
        static let getAvailablePodcastPlaybackSpeeds = "playerApi_getAvailablePodcastPlaybackSpeeds";
        static let getCurrentPodcastPlaybackSpeed = "playerApi_getCurrentPodcastPlaybackSpeed";
        static let setPodcastPlaybackSpeed = "playerApi_setPodcastPlaybackSpeed";
        static let getCrossfadeState = "playerApi_getCrossfadeState";
    }
    
    struct UserApi {
        static let fetchCapabilities = "userApi_fetchCapabilities";
        static let subscribeToCapabilityChanges = "userApi_subscribeToCapabilityChanges";
        static let unsubscribeToCapabilityChanges = "userApi_unsubscribeToCapabilityChanges";
        static let fetchLibraryStateForUri = "userApi_fetchLibraryStateForUri";
        static let addUriToLibrary = "userApi_addUriToLibrary";
        static let removeUriFromLibrary = "userApi_removeUriFromLibrary";
    }
    
    struct AppRemote {
        static let checkIfSpotifyAppIsActive = "appRemote_checkIfSpotifyAppIsActive";
        static let version = "appRemote_version";
        static let spotifyItunesItemIdentifier = "appRemote_spotifyItunesItemIdentifier";
        
        static let initializeAppRemote = "appRemote_initializeAppRemote";
        
        static let connectionParameters = "appRemote_connectionParameters";
        static let isConnected = "appRemote_isConnected";
        static let connect = "appRemote_connect";
        static let disconnect = "appRemote_disconnect";
        static let authorizeAndPlayUri = "appRemote_authorizeAndPlayUri";
        static let authorizationParametersFromURL = "appRemote_authorizationParametersFromURL";
    }
    
    struct Session {
        static let isSpotifyAppInstalled = "isSpotifyAppInstalled";
        static let initiateSessionWithScope = "initiateSessionWithScope";
        static let renewSession = "renewSession";
        static let session = "session";
        static let initializeSessionManager = "initializeSessionManager";
    }
}
