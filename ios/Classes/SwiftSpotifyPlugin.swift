import Flutter
import UIKit
import SpotifyiOS
import os

struct FlutterChannel {
    // MethodChannel
    static let methods = "spotify"
    
    // EventChannel
    static let appRemoteDelegate = "appRemoteDelegate"
    static let sessionManagerDelegate = "sessionManagerDelegate"
    static let playerState = "playerState"
    static let userCapabilities = "userCapabilities"
}

public class SwiftSpotifyPlugin: NSObject, FlutterPlugin {
    // TODO: Review public modifiers
    // MARK - State
    public var appRemote: SPTAppRemote?
    public var sessionManager: SPTSessionManager?
    
    public var methodChannel: FlutterMethodChannel?
    
    public var appRemoteEventSink: FlutterEventSink?
    public var sessionManagerEventSink: FlutterEventSink?
    public var playerStateEventSink: FlutterEventSink?
    public var userCapabilitiesEventSink: FlutterEventSink?
    
    // For SPTSessionManager initiateSession: pre-iOS 11
    public var controller: UIViewController?
    
    public static let instance: SwiftSpotifyPlugin = SwiftSpotifyPlugin()
    
    // MARK - FlutterPlugin
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let binaryMessenger = registrar.messenger();

        // Method Channel
        let methodChannel = FlutterMethodChannel(name: FlutterChannel.methods, binaryMessenger: binaryMessenger)
        registrar.addMethodCallDelegate(SwiftSpotifyPlugin.instance, channel: methodChannel)
        
        // Set State
        SwiftSpotifyPlugin.instance.methodChannel = methodChannel
        
        // Event Channels
        let appRemoteDelegateChannel = FlutterEventChannel(name: FlutterChannel.appRemoteDelegate, binaryMessenger: binaryMessenger);
        appRemoteDelegateChannel.setStreamHandler(AppRemoteDelegateStreamHandler())
        
        let sessionManagerDelegateChannel = FlutterEventChannel(name: FlutterChannel.sessionManagerDelegate, binaryMessenger: binaryMessenger);
        sessionManagerDelegateChannel.setStreamHandler(SessionManagerDelegateStreamHandler())
        
        let playerStateEventChannel = FlutterEventChannel(name: FlutterChannel.playerState, binaryMessenger: binaryMessenger);
        playerStateEventChannel.setStreamHandler(PlayerStateStreamHandler())
        
        let userCapabilitiesEventChannel = FlutterEventChannel(name: FlutterChannel.userCapabilities, binaryMessenger: binaryMessenger);
        userCapabilitiesEventChannel.setStreamHandler(UserCapabilitiesStreamHandler())
    }

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        if #available(iOS 10.0, *) {
            os_log("Calling: %@", call.method)
        } else {
            NSLog("Calling: %@", call.method)
        }
    
        switch call.method {
        // Content API
        case Methods.ContentApi.fetchRootContentItemsForType:
            ContentApiHandler.handle_fetchRootContentItemsForType_withCall(call, result: result)
        case Methods.ContentApi.fetchChildrenOfContentItem:
            ContentApiHandler.handle_fetchChildrenOfContentItem_withCall(call, result: result)
        case Methods.ContentApi.fetchRecommendedContentItemsForType:
            ContentApiHandler.handle_fetchRecommendedContentItemsForType_withCall(call, result: result)
            
        // Image API
        case Methods.ImageApi.fetchImageForItem:
            ImageApiHandler.handle_fetchImageForItem_withCall(call, result: result)
            
        // Player API
        case Methods.PlayerApi.play:
            PlayerApiHandler.handle_play_withCall(call, result: result)
        case Methods.PlayerApi.playItem:
            PlayerApiHandler.handle_playItem_withCall(call, result: result)
        case Methods.PlayerApi.resume:
            PlayerApiHandler.handle_resume_withCall(call, result: result)
        case Methods.PlayerApi.pause:
            PlayerApiHandler.handle_pause_withCall(call, result: result)
        case Methods.PlayerApi.skipToNext:
            PlayerApiHandler.handle_skipToNext_withCall(call, result: result)
        case Methods.PlayerApi.skipToPrevious:
            PlayerApiHandler.handle_skipToPrevious_withCall(call, result: result)
        case Methods.PlayerApi.seekToPosition:
            PlayerApiHandler.handle_seekToPosition_withCall(call, result: result)
        case Methods.PlayerApi.seekForward15Seconds:
            PlayerApiHandler.handle_seekForward15Seconds_withCall(call, result: result)
        case Methods.PlayerApi.seekBackward15Seconds:
            PlayerApiHandler.handle_seekBackward15Seconds_withCall(call, result: result)
        case Methods.PlayerApi.setShuffle:
            PlayerApiHandler.handle_setShuffle_withCall(call, result: result)
        case Methods.PlayerApi.setRepeatMode:
            PlayerApiHandler.handle_setRepeatMode_withCall(call, result: result)
        case Methods.PlayerApi.getPlayerState:
            PlayerApiHandler.handle_getPlayerState_withCall(call, result: result)
        case Methods.PlayerApi.subscribeToPlayerState:
            PlayerApiHandler.handle_subscribeToPlayerState_withCall(call, result: result)
        case Methods.PlayerApi.unsubscribeToPlayerState:
            PlayerApiHandler.handle_unsubscribeToPlayerState_withCall(call, result: result)
        case Methods.PlayerApi.enqueueTrackUri:
            PlayerApiHandler.handle_enqueueTrackUri_withCall(call, result: result)
        case Methods.PlayerApi.getAvailablePodcastPlaybackSpeeds:
            PlayerApiHandler.handle_getAvailablePodcastPlaybackSpeeds_withCall(call, result: result)
        case Methods.PlayerApi.getCurrentPodcastPlaybackSpeed:
            PlayerApiHandler.handle_getCurrentPodcastPlaybackSpeed_withCall(call, result: result)
        case Methods.PlayerApi.setPodcastPlaybackSpeed:
            PlayerApiHandler.handle_setPodcastPlaybackSpeed_withCall(call, result: result)
        case Methods.PlayerApi.getCrossfadeState:
            PlayerApiHandler.handle_getCrossfadeState_withCall(call, result: result)
            
        // User API
        case Methods.UserApi.fetchCapabilities:
            UserApiHandler.handle_fetchCapabilities_withCall(call, result: result)
        case Methods.UserApi.subscribeToCapabilityChanges:
            UserApiHandler.handle_subscribeToCapabilityChanges_withCall(call, result: result)
        case Methods.UserApi.unsubscribeToCapabilityChanges:
            UserApiHandler.handle_unsubscribeToCapabilityChanges_withCall(call, result: result)
        case Methods.UserApi.fetchLibraryStateForUri:
            UserApiHandler.handle_fetchLibraryStateForUri_withCall(call, result: result)
        case Methods.UserApi.addUriToLibrary:
            UserApiHandler.handle_addUriToLibrary_withCall(call, result: result)
        case Methods.UserApi.removeUriFromLibrary:
            UserApiHandler.handle_removeUriFromLibrary_withCall(call, result: result)
            
        // App Remote Methods
        case Methods.AppRemote.checkIfSpotifyAppIsActive:
            AppRemoteHandler.handle_checkIfSpotifyAppIsActive_withCall(call, result: result)
        case Methods.AppRemote.version:
            AppRemoteHandler.handle_version_withCall(call, result: result)
        case Methods.AppRemote.spotifyItunesItemIdentifier:
            AppRemoteHandler.handle_spotifyItunesItemIdentifier_withCall(call, result: result)
        case Methods.AppRemote.initializeAppRemote:
            AppRemoteHandler.handle_initializeAppRemote_withCall(call, result: result)
        case Methods.AppRemote.connectionParameters:
            AppRemoteHandler.handle_connectionParameters_withCall(call, result: result)
        case Methods.AppRemote.isConnected:
            AppRemoteHandler.handle_isConnected_withCall(call, result: result)
        case Methods.AppRemote.connect:
            AppRemoteHandler.handle_connect_withCall(call, result: result)
        case Methods.AppRemote.disconnect:
            AppRemoteHandler.handle_disconnect_withCall(call, result: result)
        case Methods.AppRemote.authorizeAndPlayUri:
            AppRemoteHandler.handle_authorizeAndPlayUri_withCall(call, result: result)
        case Methods.AppRemote.authorizationParametersFromURL:
            AppRemoteHandler.handle_authorizationParametersFromURL_withCall(call, result: result)
            
        // Session Methods
        case Methods.SessionManager.isSpotifyAppInstalled:
            SessionManagerHandler.handle_isSpotifyAppInstalled_withCall(call, result: result)
        case Methods.SessionManager.initiateSessionWithScope:
            SessionManagerHandler.handle_initiateSessionWithScope_withCall(call, result: result)
        case Methods.SessionManager.renewSession:
            SessionManagerHandler.handle_renewSession_withCall(call, result: result)
        case Methods.SessionManager.session:
            SessionManagerHandler.handle_session_withCall(call, result: result)
        case Methods.SessionManager.initializeSessionManager:
            SessionManagerHandler.handle_initializeSessionManager_withCall(call, result: result)
            
        default:
            result(FlutterMethodNotImplemented)
        }
    }
}

extension SwiftSpotifyPlugin: SPTAppRemoteDelegate, SPTSessionManagerDelegate, SPTAppRemoteUserAPIDelegate, SPTAppRemotePlayerStateDelegate {
    // MARK - SPTSessionManagerDelegate
    
    public func sessionManager(manager: SPTSessionManager, didInitiate session: SPTSession) {
        self.appRemote?.connectionParameters.accessToken = session.accessToken
        // TODO: Call method to update connection params? Or event for new access token...
        if let sink = self.sessionManagerEventSink {
            sink(sessionManagerEvent(.didInitiate, args: session.encode()))
        }
    }
    
    public func sessionManager(manager: SPTSessionManager, didFailWith error: Error) {
        if let sink = self.sessionManagerEventSink {
            sink(sessionManagerEvent(.didFail, args: error.localizedDescription))
        }
    }
    
    public func sessionManager(manager: SPTSessionManager, didRenew session: SPTSession) {
        if let sink = self.sessionManagerEventSink {
            sink(nil)
        }
    }
    
    // TODO: Have to have value preset in config
    public func sessionManager(manager: SPTSessionManager, shouldRequestAccessTokenWith code: String) -> Bool {
        return true
    }
    
    // MARK - SPTAppRemotePlayerStateDelegate
    
    public func playerStateDidChange(_ playerState: SPTAppRemotePlayerState) {
        if let sink = self.playerStateEventSink {
            sink(SpotifyPlayerState(fromSdkObject: playerState).encode())
        }
    }
    
    // MARK - SPTAppRemoteUserAPIDelegate
    
    public func userAPI(_ userAPI: SPTAppRemoteUserAPI, didReceive capabilities: SPTAppRemoteUserCapabilities) {
        if let sink = self.userCapabilitiesEventSink {
            sink(SpotifyUserCapabilities(fromSdkObject: capabilities).encode())
        }
    }
    
    // MARK - SPTAppRemoteDelegate
    
    public func appRemoteDidEstablishConnection(_ appRemote: SPTAppRemote) {
        if let sink = self.appRemoteEventSink {
            sink(appRemoteEvent(.didConnect))
        }
        
        self.appRemote?.playerAPI?.delegate = self
        self.appRemote?.playerAPI?.subscribe(toPlayerState: nil)
        
        self.appRemote?.userAPI?.delegate = self
        self.appRemote?.userAPI?.subscribe(toCapabilityChanges: nil)
    }
    
    public func appRemote(_ appRemote: SPTAppRemote, didFailConnectionAttemptWithError error: Error?) {
        if let sink = self.appRemoteEventSink {
            sink(appRemoteEvent(.didFailToConnect, args: error?.localizedDescription))
        }
    }
    
    public func appRemote(_ appRemote: SPTAppRemote, didDisconnectWithError error: Error?) {
        if let sink = self.appRemoteEventSink {
            sink(appRemoteEvent(.didDisconnect, args: error?.localizedDescription))
        }
    }
}

public extension SwiftSpotifyPlugin {
    func application(_ app:  UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) {
        self.sessionManager?.application(app, open: url, options: options)
    }
    
    @available(iOS, deprecated: 11.0)
    func setAuthPresentingController(_ controller: UIViewController?) {
        self.controller = controller
    }
}
