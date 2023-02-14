//
//  BouncyBallView.swift
//  Challenge6_v1
//
//  Created by Pedro Peçanha on 14/02/23.
//

import Foundation
import UIKit
import SpriteKit

class BouncyBallView: SKView {
    
    let ballBouncingScene = SKScene(fileNamed: "BallBouncingScene")!
    
    func configSKSceneAndView(){
        ballBouncingScene.scaleMode = .aspectFill
        self.allowsTransparency = true
        self.presentScene(ballBouncingScene)
        ballBouncingScene.view!.allowsTransparency = true
        ballBouncingScene.backgroundColor = .black.withAlphaComponent(0.8)
        self.ignoresSiblingOrder = true
//        viewConverted.showsFPS = true
//        viewConverted.showsNodeCount = true
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        configSKSceneAndView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
