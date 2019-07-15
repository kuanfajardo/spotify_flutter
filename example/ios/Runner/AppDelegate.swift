import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
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
            ContentApi.handle_fetchRootContentItemsForType_withCall(call, result: result)
        case Methods.ContentApi.fetchChildrenOfContentItem:
            ContentApi.handle_fetchChildrenOfContentItem_withCall(call, result: result)
        case Methods.ContentApi.fetchRecommendedContentItemsForType:
            ContentApi.handle_fetchRecommendedContentItemsForType_withCall(call, result: result)
            
        // Image API
        case Methods.ImageApi.fetchImageForItem:
            ImageApi.handle_fetchImageForItem_withCall(call, result: result)
            
        // Player API
        case Methods.PlayerApi.play:
            PlayerApi.handle_play_withCall(call, result: result)
        case Methods.PlayerApi.playItem:
            PlayerApi.handle_playItem_withCall(call, result: result)
        case Methods.PlayerApi.resume:
            PlayerApi.handle_resume_withCall(call, result: result)
        case Methods.PlayerApi.pause:
            PlayerApi.handle_pause_withCall(call, result: result)
        case Methods.PlayerApi.skipToNext:
            PlayerApi.handle_skipToNext_withCall(call, result: result)
        case Methods.PlayerApi.skipToPrevious:
            PlayerApi.handle_skipToPrevious_withCall(call, result: result)
        case Methods.PlayerApi.seekToPosition:
            PlayerApi.handle_seekToPosition_withCall(call, result: result)
        case Methods.PlayerApi.seekForward15Seconds:
            PlayerApi.handle_seekForward15Seconds_withCall(call, result: result)
        case Methods.PlayerApi.seekBackward15Seconds:
            PlayerApi.handle_seekBackward15Seconds_withCall(call, result: result)
        case Methods.PlayerApi.setShuffle:
            PlayerApi.handle_setShuffle_withCall(call, result: result)
        case Methods.PlayerApi.setRepeatMode:
            PlayerApi.handle_setRepeatMode_withCall(call, result: result)
        case Methods.PlayerApi.getPlayerState:
            PlayerApi.handle_getPlayerState_withCall(call, result: result)
        case Methods.PlayerApi.subscribeToPlayerState:
            PlayerApi.handle_subscribeToPlayerState_withCall(call, result: result)
        case Methods.PlayerApi.unsubscribeToPlayerState:
            PlayerApi.handle_unsubscribeToPlayerState_withCall(call, result: result)
        case Methods.PlayerApi.enqueueTrackUri:
            PlayerApi.handle_enqueueTrackUri_withCall(call, result: result)
        case Methods.PlayerApi.getAvailablePodcastPlaybackSpeeds:
            PlayerApi.handle_getAvailablePodcastPlaybackSpeeds_withCall(call, result: result)
        case Methods.PlayerApi.getCurrentPodcastPlaybackSpeed:
            PlayerApi.handle_getCurrentPodcastPlaybackSpeed_withCall(call, result: result)
        case Methods.PlayerApi.setPodcastPlaybackSpeed:
            PlayerApi.handle_setPodcastPlaybackSpeed_withCall(call, result: result)
        case Methods.PlayerApi.getCrossfadeState:
            PlayerApi.handle_getCrossfadeState_withCall(call, result: result)
            
        // User API
        case Methods.UserApi.fetchCapabilities:
            UserApi.handle_fetchCapabilities_withCall(call, result: result)
        case Methods.UserApi.subscribeToCapabilityChanges:
            UserApi.handle_subscribeToCapabilityChanges_withCall(call, result: result)
        case Methods.UserApi.unsubscribeToCapabilityChanges:
            UserApi.handle_unsubscribeToCapabilityChanges_withCall(call, result: result)
        case Methods.UserApi.fetchLibraryStateForUri:
            UserApi.handle_fetchLibraryStateForUri_withCall(call, result: result)
        case Methods.UserApi.addUriToLibrary:
            UserApi.handle_addUriToLibrary_withCall(call, result: result)
        case Methods.UserApi.removeUriFromLibrary:
            UserApi.handle_removeUriFromLibrary_withCall(call, result: result)
            
        // App Remote Methods
        case Methods.AppRemote.checkIfSpotifyAppIsActive:
            AppRemoteApi.handle_checkIfSpotifyAppIsActive_withCall(call, result: result)
        case Methods.AppRemote.version:
            AppRemoteApi.handle_version_withCall(call, result: result)
        case Methods.AppRemote.spotifyItunesItemIdentifier:
            AppRemoteApi.handle_spotifyItunesItemIdentifier_withCall(call, result: result)
        case Methods.AppRemote.initializeAppRemote:
            AppRemoteApi.handle_initializeAppRemote_withCall(call, result: result)
        case Methods.AppRemote.connectionParameters:
            AppRemoteApi.handle_connectionParameters_withCall(call, result: result)
        case Methods.AppRemote.isConnected:
            AppRemoteApi.handle_isConnected_withCall(call, result: result)
        case Methods.AppRemote.connect:
            AppRemoteApi.handle_connect_withCall(call, result: result)
        case Methods.AppRemote.disconnect:
            AppRemoteApi.handle_disconnect_withCall(call, result: result)
        case Methods.AppRemote.authorizeAndPlayUri:
            AppRemoteApi.handle_authorizeAndPlayUri_withCall(call, result: result)
        case Methods.AppRemote.authorizationParametersFromURL:
            AppRemoteApi.handle_authorizationParametersFromURL_withCall(call, result: result)
            
        // Session Methods
        case Methods.SessionManager.isSpotifyAppInstalled:
            SessionManagerApi.handle_isSpotifyAppInstalled_withCall(call, result: result)
        case Methods.SessionManager.initiateSessionWithScope:
            SessionManagerApi.handle_initiateSessionWithScope_withCall(call, result: result)
        case Methods.SessionManager.renewSession:
            SessionManagerApi.handle_renewSession_withCall(call, result: result)
        case Methods.SessionManager.session:
            SessionManagerApi.handle_session_withCall(call, result: result)
        case Methods.SessionManager.initializeSessionManager:
            SessionManagerApi.handle_initializeSessionManager_withCall(call, result: result)
            
        default:
            result(FlutterMethodNotImplemented)
        }
    }
    
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
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
