import UIKit
import Flutter
import GoogleMaps

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    // Add map api key here
    GMSServices.provideAPIKey("MAP_API_KEY")
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
