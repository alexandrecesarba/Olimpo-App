//
//  JuggleChallengeController.swift
//  Challenge6_v1
//
//  Created by Pedro Peçanha on 03/02/23.
//

import Foundation
import UIKit

class JuggleChallengeController: UIViewController {
    
    var model = JuggleChallengeModel(target: 10)
    let juggleChallengeView = JuggleChallengeView()
   
    override func loadView() {
        super.loadView()
        view = juggleChallengeView
        juggleChallengeView.directionView.text = model.direction.rawValue.capitalized
        juggleChallengeView.targetView.text = "Target: \(model.target)"
        juggleChallengeView.visionDetectionView.delegate = self
    }
    
    
    
}

extension JuggleChallengeController: VisionCommunication {
    func changeStatusView() {
        UIView.animate(withDuration: 0.6, delay: .zero,options: .curveEaseInOut, animations: {
            self.model.ballTrackingStatus = .finding
            self.juggleChallengeView.ballStatusView.text = self.model.ballTrackingStatus.rawValue
            self.juggleChallengeView.ballStatusView.backgroundColor = self.model.ballTrackingStatus.color
        })
    }
    
    
}

