import UIKit
import Flutter
import spotify

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?
      ) -> Bool {
        SwiftSpotifyPlugin.instance.setAuthPresentingController(window?.rootViewController)
        
        GeneratedPluginRegistrant.register(with: self)
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    override func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        SwiftSpotifyPlugin.instance.application(app, open: url, options: options)
        return true
    }
}
