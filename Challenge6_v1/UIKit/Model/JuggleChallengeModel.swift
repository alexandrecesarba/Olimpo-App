//
//  JuggleChallengeModel.swift
//  Challenge6_v1
//
//  Created by Pedro Peçanha on 04/02/23.
//

import Foundation

struct JuggleChallengeModel {
    
    /// Indicates if the ball is going downwards or upwards.
    var direction: Direction = .stopped
    
    /// The user's current score.
    var pointCounter: Int = 0
    
    /// The user's target score.
    var target: Int
    
    /// Indicates if the ball has been located, is being located or hasn't been located.
    var ballTrackingStatus: BallTrackingStatus = .notFound
    
    /// How many frames have we got with the ball located.
    var framesWithBall: Int = 0
    
    /// Last captured height of the ball.
    var lastHeight: CGFloat = 0
    
    /// Last position of the point counter. Used in vibration calculations.
    var pointCounterLastPosition: CGPoint = .zero
    
}
