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
    
    override func viewDidLoad() {
        var panGesture = UIPanGestureRecognizer()
        panGesture = UIPanGestureRecognizer(target: self, action: #selector(ViewController.draggedView(_:)))
        juggleChallengeView.keepyUpCounterView.addRecognizer(panGesture, label: juggleChallengeView.keepyUpCounterView.hitbox)
    }
    
    @objc func draggedView(_ sender:UIPanGestureRecognizer){
        let pointCounter = self.juggleChallengeView.keepyUpCounterView
        self.view.bringSubviewToFront(pointCounter.hitbox)
        let translation = sender.translation(in: self.view)
//        totalDistance += latestVibrationPosition.distance(to: translation)
//        if Int(totalDistance) > 6 {
//            UIImpactFeedbackGenerator(style: .rigid).impactOccurred()
//            totalDistance = 0
//        }
//        latestVibrationPosition = translation
//        vibration.selectionChanged()
        pointCounter.repositionViews(point: pointCounter.outerCircle.center, translation: translation)
        sender.setTranslation(CGPoint.zero, in: self.view)
    }
    
}

extension JuggleChallengeController: VisionResultsDelegate {
    func changeStatusView(_ amountOfResults: Int) {
        
        let framesToConfirm = 20
        
        // if it sees the ball, adds one, else, resets
        if amountOfResults > 0 {
            self.model.framesWithBall += 1
        }
        
        else {
            self.model.framesWithBall = 0
            self.model.ballTrackingStatus = .notFound
        }
        
        if self.model.framesWithBall > 0 && self.model.framesWithBall < framesToConfirm {
            self.model.ballTrackingStatus = .finding
        }
        else if self.model.framesWithBall >= framesToConfirm {
            self.model.ballTrackingStatus = .found
        }
        
        
        UIView.animate(withDuration: 0.6, delay: .zero,options: .curveEaseInOut, animations: {
                   self.juggleChallengeView.ballStatusView.text = self.model.ballTrackingStatus.rawValue
                   self.juggleChallengeView.ballStatusView.backgroundColor = self.model.ballTrackingStatus.color
               })
    }
    
}


