//
//  Extensions.swift
//  Bridged
//
//  Created by Otuniyi, Olayinka (ELS-LON) on 12/11/2021.
//

import Foundation
import UIKit
import AVKit
import AVFoundation

extension UIApplication {
  class func topMostViewController(controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
    if let navigationController = controller as? UINavigationController {
      return topMostViewController(controller: navigationController.visibleViewController)
    }
    if let tabController = controller as? UITabBarController {
      if let selected = tabController.selectedViewController {
        return topMostViewController(controller: selected)
      }
    }
    if let presented = controller?.presentedViewController {
      return topMostViewController(controller: presented)
    }
    return controller
  }
}

extension UIViewController {
  @objc func handleNavigation (button: UIButton){
    Player.shared.playVideo(play: false)
    HybridNavigator.sharedInstance.navigateToRN("Bridged",nil, nil)
  }
}
