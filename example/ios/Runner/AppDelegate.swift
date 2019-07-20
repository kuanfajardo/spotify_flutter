import UIKit
import Flutter
import spotify

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate, SPTSessionManagerDelegate, SPTAppRemoteDelegate, SPTAppRemotePlayerStateDelegate {
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?
      ) -> Bool {
        let controller: FlutterViewController = window?.rootViewController as! FlutterViewController
        SpotifyChannelState.controller = controller
        
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
