//
//  SplashScreenViewController.swift
//  Hybrid
//
//  Created by Otuniyi, Olayinka (ELS-LON) on 12/11/2021.
//

import Foundation
import AVKit
import UIKit
import AVFoundation

final class Player {
  static let shared = Player()
  @objc var videoPlayer: AVPlayer!

  private init() {
    let filepathURL = NSURL.fileURL(withPath: Bundle.main.path(forResource: "splashscreen", ofType:"mov")!)

    let asset = AVAsset(url: filepathURL)
    let playerItem = AVPlayerItem(asset: asset)
    videoPlayer = AVPlayer(playerItem: playerItem)
  }

  func playVideo(play: Bool) {
    if play {
      videoPlayer.seek(to: CMTime.zero)
      videoPlayer.play()
    } else {
      videoPlayer.pause()
    }
  }
}

@objc class SplashScreenViewController: UIViewController {
  @objc var viewController: UIViewController?
  let player = Player.shared

  @objc lazy var goToRNButton: UIButton = {
    let button = UIButton(type: .system)

    button.setTitle("GO TO RN", for: .normal)
    button.isUserInteractionEnabled = true

    button.addTarget(self, action: #selector(self.handleNavigation), for: .touchUpInside)
    button.backgroundColor = .yellow
    button.layer.cornerRadius = 25

    player.playVideo(play: false)
    return button
  }()

  @objc func loadVideo() {
    let playerLayer = AVPlayerLayer(player: player.videoPlayer)

    playerLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
    playerLayer.frame = (self.viewController?.view.frame)!

    self.viewController?.view.layer.addSublayer(playerLayer) // add video into frame


    let buttonWidth = playerLayer.frame.size.width/3 //create button frame
    let buttonShape = CGRect(x: (playerLayer.frame.size.width - buttonWidth)/2, y: playerLayer.frame.size.height/6, width: buttonWidth , height: 50)

    goToRNButton.frame = buttonShape

    self.viewController?.view.addSubview(goToRNButton) //add button to frame

    Player.shared.playVideo(play: true)

    loopVideo(videoPlayer: self.player.videoPlayer)
  }

  @objc func loopVideo(videoPlayer: AVPlayer) {
    NotificationCenter.default.addObserver(forName: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object:nil, queue: nil) {
      notification in
      Player.shared.playVideo(play: true)
    }
  }
}

