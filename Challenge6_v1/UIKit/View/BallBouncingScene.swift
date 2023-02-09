//
//  GameScene.swift
//  BouncingBall
//
//  Created by Felipe Gameleira on 07/02/23.
//

import SpriteKit
import GameplayKit


class BallBouncingScene: SKScene {
    
    var velocity: CGFloat = 10; // velocity
    var gravity: CGFloat = -1; // force of gravity
    var ballY: CGFloat = -150; // the ball location
    var floorY: CGFloat = -300; // the floor location
    var dampening: CGFloat = 1; // a float 0 to 1, where 0 will mean no bounce
    
    
    lazy var ballLabel: SKSpriteNode = {
        var ball = SKSpriteNode(imageNamed: "ball_inverted")
        ball.size = CGSize(width: 100, height: 100)
        return ball
    }()
    
    
    override func didMove(to view: SKView) {
        self.addChild(ballLabel)
//        print(ballLabel.position)
//        ballLabel.run(SKAction.rotate(toAngle: -200, duration: 60))
//        backgroundColor = .red.withAlphaComponent(0.1)
        
    
    }
    
    
    func touchDown(atPoint pos : CGPoint) {

    }
    
    func touchMoved(toPoint pos : CGPoint) {
        
    }
    
    func touchUp(atPoint pos : CGPoint) {
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {

        
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        velocity += gravity; // increases velocity with gravity
        ballY += velocity; // update position
//        print(ballY)

        if (ballY < floorY) {
          ballY = floorY; // don't let the ball past floor
          velocity *= dampening; // dampens velocity on the bounce
          velocity *= -1; // change direction
        }

        ballLabel.position = CGPoint(x:0, y:ballY);
        ballLabel.zRotation -= 0.08
        
    }
}
