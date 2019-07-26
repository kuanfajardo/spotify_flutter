//
//  Codable.swift
//  Runner
//
//  Created by Juan Diego Fajardo on 7/26/19.
//  Copyright © 2019 The Chromium Authors. All rights reserved.
//

import Foundation

typealias FlutterChannelObject = Dictionary<String, Any?>

protocol FlutterChannelDecodable {
    // Decode
    init(fromChannelObject channelObject: FlutterChannelObject)
}

protocol FlutterChannelEncodable {
    // Encode
    func encode() -> FlutterChannelObject
}

typealias FlutterChannelCodable = FlutterChannelDecodable & FlutterChannelEncodable

protocol SpotifySDKConvertible { // To be implemented by plugin classes
    associatedtype T // Abstract superclass in SpotifyiOS SDK
    init(fromSdkObject: T)
}

class CodecResultExtractor {
    let channelObject: FlutterChannelObject
    
    init(_ channelObject: FlutterChannelObject) {
        self.channelObject = channelObject
    }
    
    func get<T>(_ key: String) -> T? {
        guard let value = channelObject[key] as? T else {
            return nil
        }
        
        return value
    }
}
