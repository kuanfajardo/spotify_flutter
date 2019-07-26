//
//  Codec.swift
//  Runner
//
//  Created by Juan Diego Fajardo on 7/15/19.
//  Copyright © 2019 The Chromium Authors. All rights reserved.
//

import Foundation

typealias CodecResult = Dictionary<String, Any?>

protocol FlutterChannelDecodable {
    // Decode
    init(fromCodecResult codecResult: CodecResult)
}

protocol FlutterChannelEncodable {
    // Encode
    func encode() -> CodecResult
}

typealias Codec = FlutterChannelDecodable & FlutterChannelEncodable

protocol SpotifySDKConvertible { // To be implemented by plugin classes
    associatedtype T // Abstract superclass in SpotifyiOS SDK
    init(fromSdkObject: T)
}

class CodecResultExtractor {
    let codecResult: CodecResult
    
    init(_ codecResult: CodecResult) {
        self.codecResult = codecResult
    }
    
    func get<T>(_ key: String) -> T? {
        guard let value = codecResult[key] as? T else {
            return nil
        }
        
        return value
    }
}
