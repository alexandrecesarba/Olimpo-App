//
//  JuggleChallengeModel.swift
//  Challenge6_v1
//
//  Created by Pedro Peçanha on 04/02/23.
//

import Foundation

struct JuggleChallengeModel {
    
    var direction: Direction = .stopped
    var pointCounter: Int = 0
    var target: Int
    var ballTrackingStatus: BallTrackingStatus = .notFound
    var framesWithBall: Int = 0
    var lastHeight: CGFloat = 0
    
}
