//
//  JuggleChallengeModel.swift
//  Challenge6_v1
//
//  Created by Pedro Peçanha on 04/02/23.
//

import Foundation

struct JuggleChallengeModel {
    
    public static var shared = JuggleChallengeModel(framesTarget: 40)
    /// Indicates if the ball is going downwards or upwards.
    var direction: Direction = .stopped

    /// Indicates if the ball has been located, is being located or hasn't been located.
    var ballTrackingStatus: BallTrackingStatus = .notFound
    
    /// How many frames are the maximum to identify the ball.
    var framesTarget: CGFloat
    
    /// How many frames have we got with the ball located.
    var framesWithBall: Int = 0
    
    /// Last captured height of the ball.
    var lastHeight: CGFloat = 0
    
    /// Last position of the point counter. Used in vibration calculations.
    var pointCounterLastPosition: CGPoint = .zero
    
    
}
