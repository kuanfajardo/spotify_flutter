//
//  SpotifyContentItem.swift
//  Runner
//
//  Created by Juan Diego Fajardo on 7/15/19.
//  Copyright © 2019 The Chromium Authors. All rights reserved.
//

import Foundation
import SpotifyiOS

class SpotifyContentItem: NSObject, SPTAppRemoteContentItem, FlutterChannelCodable, SpotifySDKConvertible {
    var title: String?
    var subtitle: String?
    var identifier: String = ""
    var uri: String = ""
    var isAvailableOffline: Bool = false
    var isPlayable: Bool = false
    var isContainer: Bool = false
    var children: [SPTAppRemoteContentItem]?
    
    var imageIdentifier: String = ""
    
    typealias T = SPTAppRemoteContentItem
    
    required init(fromSdkObject object: SPTAppRemoteContentItem) {
        self.title = object.title
        self.subtitle = object.subtitle
        self.identifier = object.identifier
        self.uri = object.uri
        self.isAvailableOffline = object.isAvailableOffline
        self.isPlayable = object.isPlayable
        self.isContainer = object.isContainer
        self.children = object.children
        self.imageIdentifier = object.imageIdentifier
    }
    
    // Codec Methods
    required init(fromChannelObject channelObject: FlutterChannelObject) {
        let extractor = CodecResultExtractor(channelObject)
        
        self.title = extractor.get(CodecKeys.ContentItem.subtitle)
        self.subtitle = extractor.get(CodecKeys.ContentItem.subtitle)
        self.identifier = extractor.get(CodecKeys.ContentItem.identifier)!
        self.uri = extractor.get(CodecKeys.ContentItem.uri)!
        self.isAvailableOffline = extractor.get(CodecKeys.ContentItem.isAvailableOffline)!
        self.isPlayable = extractor.get(CodecKeys.ContentItem.isPlayable)!
        self.isContainer = extractor.get(CodecKeys.ContentItem.isContainer)!
        self.children = extractor.get(CodecKeys.ContentItem.children)
        self.imageIdentifier = extractor.get(CodecKeys.ContentItem.imageIdentifier)!
    }
    
    func encode() -> FlutterChannelObject {
        return [
            CodecKeys.ContentItem.title: title,
            CodecKeys.ContentItem.subtitle: subtitle,
            CodecKeys.ContentItem.identifier: identifier,
            CodecKeys.ContentItem.uri: uri,
            CodecKeys.ContentItem.isAvailableOffline: isAvailableOffline,
            CodecKeys.ContentItem.isPlayable: isPlayable,
            CodecKeys.ContentItem.isContainer: isContainer,
            CodecKeys.ContentItem.children: children,
            CodecKeys.ContentItem.imageIdentifier: imageIdentifier,
        ]
    }
}
