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
        SwiftSpotifyPlugin.controller = controller
        
        GeneratedPluginRegistrant.register(with: self)
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    override func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        SwiftSpotifyPlugin.sessionManager?.application(app, open: url, options: options)
        return true
    }
}
