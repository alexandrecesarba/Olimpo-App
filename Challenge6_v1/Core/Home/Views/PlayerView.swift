//
//  PlayerView.swift
//  Challenge6_v1
//
//  Created by Alexandre César Brandão de Andrade on 10/03/23.
//

import SwiftUI
import AVFoundation
import AVKit

// MARK: UIKit View

struct PlayerView: UIViewRepresentable {

    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<PlayerView>) {
    }

    func makeUIView(context: Context) -> UIView {
        return LoopingPlayerUIView(frame: .zero)
    }
}

class LoopingPlayerUIView: UIView {


    private let playerLayer = AVPlayerLayer()
    private var playerLooper: AVPlayerLooper?
    let player = AVQueuePlayer()


    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(frame: CGRect) {
        super.init(frame: .zero)
        // Load the resource
        let fileUrl = Bundle.main.url(forResource: "PedroDemoVideoCut", withExtension: "mov")!
        let asset = AVAsset(url: fileUrl)
        let item = AVPlayerItem(asset: asset)

        // Setup the player

        playerLayer.player = player
        playerLayer.videoGravity = .resizeAspect
        layer.addSublayer(playerLayer)


        // MARK: Not working
            print("Está apresentando")

            // Create a new player looper with the queue player and template item
            playerLooper = AVPlayerLooper(player: player, templateItem: item)



            // Allows video to resume playing after app was closed
            NotificationCenter.default.addObserver(self, selector: #selector(self.playVideo), name: UIApplication.willEnterForegroundNotification, object: nil)

            // Start the movie
            player.play()


    }

    @objc func playVideo() {
        self.player.play()
    }

    @objc func pauseVideo() {
        self.player.pause()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        playerLayer.frame = frame
    }
}

extension AVPlayer{

    var isPlaying: Bool{
        return rate != 0 && error == nil
    }
}
