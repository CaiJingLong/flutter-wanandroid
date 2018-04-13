import UIKit
import Flutter

@UIApplicationMain
@objc
class AppDelegate: FlutterAppDelegate {
    override func application(_ application: UIApplication,didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        GeneratedPluginRegistrant.register(with: self)
        
        let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
        
        let channel = FlutterMethodChannel(name: "com.github.caijinglong.flutterwanandroid", binaryMessenger: controller)
        
        channel.setMethodCallHandler { (call, result) in
            if(call.method == "starturl"){
                let webCtl = WebViewCtl()
                let url = call.arguments as! String
                webCtl.url = url
//                controller.navigationController?.pushViewController(webCtl, animated: true)
                
//                controller.view.addSubview(createWebview(view: controller.view, url: url))
                
                let webview = MyWebView(frame: controller.view.frame, url: url)
                controller.view.addSubview(webview)
            }
        }
        
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
}
