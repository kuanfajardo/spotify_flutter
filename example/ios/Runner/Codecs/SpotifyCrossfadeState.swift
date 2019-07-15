//
//  SpotifyCrossfadeState.swift
//  Runner
//
//  Created by Juan Diego Fajardo on 7/15/19.
//  Copyright © 2019 The Chromium Authors. All rights reserved.
//

import Foundation

class SpotifyCrossfadeState: NSObject, SPTAppRemoteCrossfadeState {
    var isEnabled: Bool
    var duration: Int
    
    init(isEnabled: Bool, duration: Int) {
        self.isEnabled = isEnabled
        self.duration = duration
    }
}
