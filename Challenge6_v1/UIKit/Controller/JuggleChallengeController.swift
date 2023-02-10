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
        self.juggleChallengeView.resetButtonView.addTarget(self, action: #selector(resetButtonPressed), for: .touchUpInside)
    }
    
    func addScore(){
        self.model.pointCounter += 1
        self.juggleChallengeView.keepyUpCounterView.bounceAnimation()
        if self.model.pointCounter == self.model.target {
            self.juggleChallengeView.keepyUpCounterView.paintBalls(color: .greenCircle)
        }
        self.juggleChallengeView.keepyUpCounterView.setScore(score: self.model.pointCounter)
    }
    
    
    func setLastHeight(_ lastHeight: CGFloat){
        self.model.lastHeight = lastHeight
    }
    
    @objc func resetButtonPressed() {
        self.model.pointCounter = 0  // contador aqui 
        self.juggleChallengeView.keepyUpCounterView.pointCounterView.text = "0"
        self.juggleChallengeView.keepyUpCounterView.bounceAnimation()
        self.juggleChallengeView.keepyUpCounterView.paintBalls(color: .whiteCircle)
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
    
    
    func updateDirectionStatus(objectVerticalSize: CGFloat, currentHeight: CGFloat) {
        
        guard self.model.ballTrackingStatus == .found else {return}
        
        switch self.model.direction {
            case .upwards:
                if currentHeight > self.model.lastHeight + objectVerticalSize/5 {
                    self.model.direction = .downwards
                }
            case .downwards:
                if currentHeight < self.model.lastHeight - objectVerticalSize/5 {
                    self.model.direction = .upwards
                    addScore()
                }
            case .stopped:
                currentHeight > self.model.lastHeight + objectVerticalSize/7 ? (self.model.direction = .downwards) : (self.model.direction = .upwards)
        }
        
        self.juggleChallengeView.directionView.text = self.model.direction.rawValue.capitalized
        
        setLastHeight(currentHeight)
        
    }
    
    func updateStatusView(_ amountOfResults: Int) {
        
        let framesToConfirm = 50
        
        // two behaviours, one before a ball is located, another when a ball has already been located
        
        // if it sees the ball, adds one, else, resets
        
        if self.model.ballTrackingStatus != .found {
            
            if amountOfResults > 0 {
                self.model.framesWithBall += 1
            }
            
            else {
                self.model.framesWithBall = 0
                self.model.ballTrackingStatus = .notFound
            }
            
            if self.model.framesWithBall > framesToConfirm/3 && self.model.framesWithBall < framesToConfirm {
                self.model.ballTrackingStatus = .finding
            }
            else if self.model.framesWithBall >= framesToConfirm {
                self.model.ballTrackingStatus = .found
            }
        }
        
        else {
            if amountOfResults == 0 {
                self.model.framesWithBall -= 2
                if self.model.framesWithBall < 0 {self.model.framesWithBall = 0}
            }
            
            if self.model.framesWithBall == 0 {
                self.model.ballTrackingStatus = .notFound
            }
        }
        
        
        UIView.animate(withDuration: 0.6, delay: .zero,options: .curveEaseInOut, animations: {
                   self.juggleChallengeView.ballStatusView.text = self.model.ballTrackingStatus.rawValue
                   self.juggleChallengeView.ballStatusView.backgroundColor = self.model.ballTrackingStatus.color
               })
    }
    
    
}


