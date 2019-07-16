//
//  Keys.swift
//  Runner
//
//  Created by Juan Diego Fajardo on 7/13/19.
//  Copyright © 2019 The Chromium Authors. All rights reserved.
//

import Foundation

struct HandlerKeys {
    struct ContentApi {
        // SpotifyContentApi.fetchRecommendedContentItemsForType
        static let contentType = "contentType"
        static let flattenContainers = "flattenContainers"
    }
    struct ImageApi {
        // SpotifyImageApi.fetchImageForItem
        static let imageItem = "imageItem"
        static let size = "size"
    }
    struct PlayerApi {
        // SpotifyPlayerAPI.playItem
        static let contentItem = "contentItem"
        static let startIndex = "startIndex"
    }
    struct AppRemote {
        // Spotify.initializeAppRemote
        static let configuration = "configuration"
        static let logLevel = "logLevel"
        static let connectionParams = "connectionParams"
    }
    struct SessionManager {
        // SessionManager.initiateSessionWithScope
        static let scope = "scope"
        static let options = "options"
    }
    struct Error {
        static let argsErrorMethodName = "method"
        static let argsErrorParameterName = "parameterName"
    }
}

struct CodecKeys {
    struct ContentItem {
        static let title = "title"
        static let subtitle = "subtitle"
        static let identifier = "identifier"
        static let uri = "uri"
        static let isAvailableOffline = "isAvailableOffline"
        static let isPlayable = "isPlayable"
        static let isContainer = "isContainer"
        static let children = "children"
        static let imageIdentifier = "imageIdentifier"
    }
    struct Image {
        static let imageIdentifier = "imageIdentifier"
    }
    struct PlayerState {
        static let track = "track"
        static let playbackPosition = "playbackPosition"
        static let playbackSpeed = "playbackSpeed"
        static let isPaused = "isPaused"
        static let playbackRestrictions = "playbackRestrictions"
        static let playbackOptions = "playbackOptions"
        static let contextTitle = "contextTitle"
        static let contextUri = "contextUri"
    }
    struct PodcastPlaybackSpeed {
        static let value = "value"
    }
    struct CrossfadeState {
        static let isEnabled = "isEnabled"
        static let duration = "duration"
    }
    struct LibraryState {
        static let uri = "uri"
        static let isAdded = "isAdded"
        static let canAdd = "canAdd"
    }
    struct UserCapabilities {
        static let canPlayOnDemand = "canPlayOnDemand"
    }
    struct Configuration {
        static let clientId = "clientId"
        static let redirectUrl = "redirectUrl"
        static let tokenSwapUrl = "tokenSwapUrl"
        static let tokenRefreshUrl = "tokenRefreshUrl"
        static let playUri = "playUri"
    }
    struct ConnectionParams {
        static let accessToken = "accessToken"
        static let defaultImageSize = "defaultImageSize"
        static let imageFormat = "imageFormat"
        static let protocolVersion = "protocolVersion"
    }
    struct Session {
        static let accessToken = "accessToken"
        static let refreshToken = "refreshToken"
        static let expirationDate = "expirationDate"
        static let scope = "scope"
        static let isExpired = "isExpired"
    }
    struct CodecableSize {
        static let width = "width"
        static let height = "height"
    }
    struct CodecableImage {
        static let imageData = "imageData"
    }
}
