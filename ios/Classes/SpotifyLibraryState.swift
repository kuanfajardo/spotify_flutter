//
//  SpotifyLibraryState.swift
//  Runner
//
//  Created by Juan Diego Fajardo on 7/15/19.
//  Copyright © 2019 The Chromium Authors. All rights reserved.
//

import Foundation
import SpotifyiOS

class SpotifyLibraryState: NSObject, SPTAppRemoteLibraryState, Codec {
    var uri: String
    var isAdded: Bool
    var canAdd: Bool
    
    init(fromSdkObject object: SPTAppRemoteLibraryState) {
        self.uri = object.uri
        self.isAdded = object.isAdded
        self.canAdd = object.canAdd
    }
    
    required init(fromCodecResult codecResult: CodecResult) {
        let extractor = CodecResultExtractor(codecResult)
        
        self.uri = extractor.get(CodecKeys.LibraryState.uri)!
        self.isAdded = extractor.get(CodecKeys.LibraryState.isAdded)!
        self.canAdd = extractor.get(CodecKeys.LibraryState.canAdd)!
    }
    
    func encode() -> CodecResult {
        return [
            CodecKeys.LibraryState.uri: uri,
            CodecKeys.LibraryState.isAdded: isAdded,
            CodecKeys.LibraryState.canAdd: canAdd,
        ]
    }
}
