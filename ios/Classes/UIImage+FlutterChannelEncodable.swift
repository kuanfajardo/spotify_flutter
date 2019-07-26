//
//  UIImage+FlutterChannelEncodable.swift
//  spotify
//
//  Created by Juan Diego Fajardo on 7/26/19.
//

import Foundation

extension UIImage: FlutterChannelEncodable {
    func encode() -> FlutterChannelObject {
        let imageData = UIImagePNGRepresentation(self)
        return [
            CodecKeys.CodecableImage.imageData: imageData
        ]
    }
}
