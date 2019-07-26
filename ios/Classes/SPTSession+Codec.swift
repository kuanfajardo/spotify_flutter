//
//  SPTSession+Codec.swift
//  Runner
//
//  Created by Juan Diego Fajardo on 7/17/19.
//  Copyright © 2019 The Chromium Authors. All rights reserved.
//

import Foundation
import SpotifyiOS

extension SPTSession: FlutterChannelEncodable {
    func encode() -> CodecResult {
        return [
            CodecKeys.Session.accessToken: self.accessToken,
            CodecKeys.Session.refreshToken: self.refreshToken,
            CodecKeys.Session.isExpired: self.isExpired,
            CodecKeys.Session.expirationDate: self.expirationDate, // TODO
            CodecKeys.Session.scope: self.scope, // TODO
        ]
    }
}
