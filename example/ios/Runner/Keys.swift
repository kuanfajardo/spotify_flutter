//
//  Keys.swift
//  Runner
//
//  Created by Juan Diego Fajardo on 7/13/19.
//  Copyright © 2019 The Chromium Authors. All rights reserved.
//

import Foundation

struct Keys {
    struct ContentApi {
        // SpotifyContentApi.fetchRecommendedContentItemsForType
        static let contentType = "contentType"
        static let flattenContainers = "flattenContainers"
    }
    struct ImageApi {
        // SpotifyImageApi.fetchImageForItem
        static let imageItem = "imageItem";
        static let size = "size";
    }
    struct PlayerApi {
        // SpotifyPlayerAPI.playItem
        static let contentItem = "contentItem";
        static let startIndex = "startIndex";
    }
    struct AppRemote {
        // Spotify.initializeAppRemote
        static let configuration = "configuration";
        static let logLevel = "logLevel";
        static let connectionParams = "connectionParams";
    }
    struct SessionManager {
        // SessionManager.initiateSessionWithScope
        static let scope = "scope";
        static let options = "options";
    }
}
