//
//  Events.swift
//  spotify
//
//  Created by Juan Diego Fajardo on 7/24/19.
//

import Foundation

enum AppRemoteEvent: String {
    case didConnect = "didConnect"
    case didFailToConnect = "didFailToConnect"
    case didDisconnect = "didDisconnect"
    case updatedAccessToken = "updatedAccessToken"
}

func appRemoteEvent(_ event: AppRemoteEvent, args: Any? = nil) -> FlutterChannelObject {
    return [
        "eventType": event.rawValue,
        "args": args
    ]
}

enum SessionManagerEvent: String {
    case didInitiate = "didInitiate"
    case didFail = "didFail"
    case didRenew = "didRenew"
}

func sessionManagerEvent(_ event: SessionManagerEvent, args: Any? = nil) -> FlutterChannelObject {
    return [
        "eventType": event.rawValue,
        "args": args
    ]
}
