//
//  CGSize+FlutterChannelDecodable.swift
//  spotify
//
//  Created by Juan Diego Fajardo on 7/26/19.
//

import Foundation

extension CGSize: FlutterChannelDecodable {
    init(fromChannelObject object: FlutterChannelObject) {
        let extractor = CodecResultExtractor(object)
        
        let width: Double = extractor.get(CodecKeys.CodecableSize.width)!
        let height: Double = extractor.get(CodecKeys.CodecableSize.height)!
        
        self.init(width: width, height: height)
    }
}
