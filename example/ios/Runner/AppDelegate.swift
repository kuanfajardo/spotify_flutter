import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate, SPTSessionManagerDelegate, SPTAppRemoteDelegate, SPTAppRemotePlayerStateDelegate {
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?
      ) -> Bool {
        let controller: FlutterViewController = window?.rootViewController as! FlutterViewController
        let spotifyChannel = FlutterMethodChannel(name: "spotify", binaryMessenger: controller)
        
        SpotifyChannelState.controller = controller
        
        spotifyChannel.setMethodCallHandler { (call: FlutterMethodCall, result: @escaping FlutterResult) in
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
        
        GeneratedPluginRegistrant.register(with: self)
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    override func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        SpotifyChannelState.sessionManager?.application(app, open: url, options: options)
        return true
    }
    
    func sessionManager(manager: SPTSessionManager, didInitiate session: SPTSession) {
        print("success", session)
        SpotifyChannelState.appRemote?.connectionParameters.accessToken = session.accessToken
        SpotifyChannelState.appRemote?.connect()
    }
    
    func sessionManager(manager: SPTSessionManager, didFailWith error: Error) {
        print("fail", error)
    }
    
    func sessionManager(manager: SPTSessionManager, didRenew session: SPTSession) {
        print("renewed", session)
    }
    
    func appRemoteDidEstablishConnection(_ appRemote: SPTAppRemote) {
        print("connected")
        // Connection was successful, you can begin issuing commands
        SpotifyChannelState.appRemote?.playerAPI?.delegate = self
        SpotifyChannelState.appRemote?.playerAPI?.subscribe(toPlayerState: { (result, error) in
            if let error = error {
                debugPrint(error.localizedDescription)
            }
        })
    }
    
    func appRemote(_ appRemote: SPTAppRemote, didDisconnectWithError error: Error?) {
        print("disconnected")
    }
    
    func appRemote(_ appRemote: SPTAppRemote, didFailConnectionAttemptWithError error: Error?) {
        print("failed")
    }
    
    func playerStateDidChange(_ playerState: SPTAppRemotePlayerState) {
        debugPrint("Track name: %@", playerState.track.name)
    }
    
    override func applicationWillResignActive(_ application: UIApplication) {
        if let isConnected = SpotifyChannelState.appRemote?.isConnected {
            if (isConnected) {
                SpotifyChannelState.appRemote?.disconnect()
            }
        }
    }
    
    override func applicationDidBecomeActive(_ application: UIApplication) {
        if let _ = SpotifyChannelState.appRemote?.connectionParameters.accessToken {
            SpotifyChannelState.appRemote?.connect()
        }
    }
}

struct SpotifyChannelState {
    static var appRemote: SPTAppRemote?
    static var sessionManager: SPTSessionManager?
    
    static var session: SPTSession? {
        get {
            return SpotifyChannelState.sessionManager?.session
        }
    }
    
    static var controller: UIViewController?
}
