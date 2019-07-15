//
//  SpotifyContentItem.swift
//  Runner
//
//  Created by Juan Diego Fajardo on 7/15/19.
//  Copyright © 2019 The Chromium Authors. All rights reserved.
//

import Foundation

class SpotifyContentItem: NSObject, SPTAppRemoteContentItem {
    var imageIdentifier: String = ""
    var title: String?
    var subtitle: String?
    var identifier: String = ""
    var uri: String = ""
    var isAvailableOffline: Bool = false
    var isPlayable: Bool = false
    var isContainer: Bool = false
    var children: [SPTAppRemoteContentItem]?
    
    init(uri: String) {
        self.uri = uri
    }
}
