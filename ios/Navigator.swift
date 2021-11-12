//
//  Navigator.swift
//  Bridged
//
//  Created by Otuniyi, Olayinka (ELS-LON) on 12/11/2021.
//

import Foundation
import UIKit

class ReactNativeBridgeDelegate: NSObject, RCTBridgeDelegate {
  let jsCodeLocation: URL = RCTBundleURLProvider.sharedSettings().jsBundleURL(forBundleRoot: "index", fallbackResource:nil)
  
  func sourceURL(for bridge: RCTBridge!) -> URL! {
    return jsCodeLocation
  }
}

final class HybridNavigator: NSObject {
  static let sharedInstance = HybridNavigator()
  var window: UIWindow?
  var bridge: RCTBridge!
  var actionController: UIViewController!
  
  private override init() {
    self.bridge = RCTBridge(delegate: ReactNativeBridgeDelegate(), launchOptions: nil)
  }
  
  func getVCFromModuleName(_ moduleName: String,_ initialProperties: NSDictionary?, _ launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> UIViewController {
        var props: [NSObject : AnyObject]? = nil
        if (initialProperties != nil) {
          props = initialProperties! as [NSObject : AnyObject]
        }
    
    let rootView = RCTRootView(bridge: self.bridge, moduleName: moduleName, initialProperties: props)
    
    self.window = UIWindow(frame: UIScreen.main.bounds)
    let rootViewController = UIViewController()
    
    rootViewController.view = rootView
    
    return rootViewController
  }
  
  @objc func navigateToRN(_ moduleName: String,_ initialProperties: NSDictionary?, _ launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {
    let vc = getVCFromModuleName(moduleName, initialProperties, launchOptions)
    
    DispatchQueue.main.async {
      let navController = UINavigationController(rootViewController: vc)
      
      navController.modalPresentationStyle = .fullScreen
      
      let topController = UIApplication.topMostViewController()
      
      topController?.present(navController, animated: true, completion: nil)
    }
  }
}

@objc(CustomRN)
class CustomRN: NSObject {
  @objc func goBack() -> Void {
    DispatchQueue.main.async {
      let topController = UIApplication.topMostViewController()
      let player = Player.shared
      player.playVideo(play:true)

      topController?.dismiss(animated: true, completion: nil)
    }
  }
}
