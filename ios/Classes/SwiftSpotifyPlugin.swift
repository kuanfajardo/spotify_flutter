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
        
        let contentApiHandler = ContentApiHandler()
        let imageApiHandler = ImageApiHandler()
        let playerApiHandler = PlayerApiHandler()
        let userApiHandler = UserApiHandler()
        let appRemoteHandler = AppRemoteHandler()
        let sessionManagerHandler = SessionManagerHandler()
    
        switch call.method {
        // Content API
        case Methods.ContentApi.fetchRootContentItemsForType:
            contentApiHandler.handle(fetchRootContentItemsForType: call, result: result)
        case Methods.ContentApi.fetchChildrenOfContentItem:
            contentApiHandler.handle(fetchChildrenOfContentItem: call, result: result)
        case Methods.ContentApi.fetchRecommendedContentItemsForType:
            contentApiHandler.handle(fetchRecommendedContentItemsForType: call, result: result)
            
        // Image API
        case Methods.ImageApi.fetchImageForItem:
            imageApiHandler.handle(fetchImageForItem: call, result: result)
            
        // Player API
        case Methods.PlayerApi.play:
            playerApiHandler.handle(play: call, result: result)
        case Methods.PlayerApi.playItem:
            playerApiHandler.handle(playItem: call, result: result)
        case Methods.PlayerApi.resume:
            playerApiHandler.handle(resume: call, result: result)
        case Methods.PlayerApi.pause:
            playerApiHandler.handle(pause: call, result: result)
        case Methods.PlayerApi.skipToNext:
            playerApiHandler.handle(skipToNext: call, result: result)
        case Methods.PlayerApi.skipToPrevious:
            playerApiHandler.handle(skipToPrevious: call, result: result)
        case Methods.PlayerApi.seekToPosition:
            playerApiHandler.handle(seekToPosition: call, result: result)
        case Methods.PlayerApi.seekForward15Seconds:
            playerApiHandler.handle(seekForward15Seconds: call, result: result)
        case Methods.PlayerApi.seekBackward15Seconds:
            playerApiHandler.handle(seekBackward15Seconds: call, result: result)
        case Methods.PlayerApi.setShuffle:
            playerApiHandler.handle(setShuffle: call, result: result)
        case Methods.PlayerApi.setRepeatMode:
            playerApiHandler.handle(setRepeatMode: call, result: result)
        case Methods.PlayerApi.getPlayerState:
            playerApiHandler.handle(getPlayerState: call, result: result)
        case Methods.PlayerApi.subscribeToPlayerState:
            playerApiHandler.handle(subscribeToPlayerState: call, result: result)
        case Methods.PlayerApi.unsubscribeToPlayerState:
            playerApiHandler.handle(unsubscribeToPlayerState: call, result: result)
        case Methods.PlayerApi.enqueueTrackUri:
            playerApiHandler.handle(enqueueTrackUri: call, result: result)
        case Methods.PlayerApi.getAvailablePodcastPlaybackSpeeds:
            playerApiHandler.handle(getAvailablePodcastPlaybackSpeeds: call, result: result)
        case Methods.PlayerApi.getCurrentPodcastPlaybackSpeed:
            playerApiHandler.handle(getCurrentPodcastPlaybackSpeed: call, result: result)
        case Methods.PlayerApi.setPodcastPlaybackSpeed:
            playerApiHandler.handle(setPodcastPlaybackSpeed: call, result: result)
        case Methods.PlayerApi.getCrossfadeState:
            playerApiHandler.handle(getCrossfadeState: call, result: result)
            
        // User API
        case Methods.UserApi.fetchCapabilities:
            userApiHandler.handle(fetchCapabilities: call, result: result)
        case Methods.UserApi.subscribeToCapabilityChanges:
            userApiHandler.handle(subscribeToCapabilityChanges: call, result: result)
        case Methods.UserApi.unsubscribeToCapabilityChanges:
            userApiHandler.handle(unsubscribeToCapabilityChanges: call, result: result)
        case Methods.UserApi.fetchLibraryStateForUri:
            userApiHandler.handle(fetchLibraryStateForUri: call, result: result)
        case Methods.UserApi.addUriToLibrary:
            userApiHandler.handle(addUriToLibrary: call, result: result)
        case Methods.UserApi.removeUriFromLibrary:
            userApiHandler.handle(removeUriFromLibrary: call, result: result)
            
        // App Remote Methods
        case Methods.AppRemote.checkIfSpotifyAppIsActive:
            appRemoteHandler.handle(checkIfSpotifyAppIsActive: call, result: result)
        case Methods.AppRemote.version:
            appRemoteHandler.handle(version: call, result: result)
        case Methods.AppRemote.spotifyItunesItemIdentifier:
            appRemoteHandler.handle(spotifyItunesItemIdentifier: call, result: result)
        case Methods.AppRemote.initializeAppRemote:
            appRemoteHandler.handle(initializeAppRemote: call, result: result)
        case Methods.AppRemote.connectionParameters:
            appRemoteHandler.handle(connectionParameters: call, result: result)
        case Methods.AppRemote.isConnected:
            appRemoteHandler.handle(isConnected: call, result: result)
        case Methods.AppRemote.connect:
            appRemoteHandler.handle(connect: call, result: result)
        case Methods.AppRemote.disconnect:
            appRemoteHandler.handle(disconnect: call, result: result)
        case Methods.AppRemote.authorizeAndPlayUri:
            appRemoteHandler.handle(authorizeAndPlayUri: call, result: result)
        case Methods.AppRemote.authorizationParametersFromURL:
            appRemoteHandler.handle(authorizationParametersFromURL: call, result: result)
            
        // Session Methods
        case Methods.SessionManager.isSpotifyAppInstalled:
            sessionManagerHandler.handle(isSpotifyAppInstalled: call, result: result)
        case Methods.SessionManager.initiateSessionWithScope:
            sessionManagerHandler.handle(initiateSessionWithScope: call, result: result)
        case Methods.SessionManager.renewSession:
            sessionManagerHandler.handle(renewSession: call, result: result)
        case Methods.SessionManager.session:
            sessionManagerHandler.handle(session: call, result: result)
        case Methods.SessionManager.initializeSessionManager:
            sessionManagerHandler.handle(initializeSessionManager: call, result: result)
            
        default:
            result(FlutterMethodNotImplemented)
        }
    }
    
    // MARK - UIApplicationDelegate (via FlutterPlugin)
    
    public func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [AnyHashable : Any] = [:]) -> Bool {
        self.controller = application.delegate?.window??.rootViewController
        return true
    }
    
    public func application(_ application: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        self.sessionManager?.application(application, open: url, options: options)
        return true
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
