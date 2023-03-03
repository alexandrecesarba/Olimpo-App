//
//  JuggleChallengeController.swift
//  Challenge6_v1
//
//  Created by Pedro Peçanha on 03/02/23.
//

import Foundation
import UIKit
import SwiftUI
import GameKit

class JuggleChallengeController: UIViewController, UIGestureRecognizerDelegate {
    
    var model = JuggleChallengeModel.shared
    let juggleChallengeView = JuggleChallengeView()
    let swiftUI_View = UIHostingController(rootView: ContentView())

    override func loadView() {
        super.loadView()
        view = juggleChallengeView
        juggleChallengeView.foundBallView.directionView.text = model.direction.rawValue.capitalized
//        juggleChallengeView.targetView.text = "Target: \(model.target)"
        juggleChallengeView.visionDetectionView.delegate = self
        self.model.ballTrackingStatus = .notFound
        hideOtherViews()
    }
    
    override func viewDidLoad() {
        self.juggleChallengeView.backButtonView.backButton.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
        self.juggleChallengeView.foundBallView.resetButtonView.addTarget(self, action: #selector(resetButtonPressed), for: .touchUpInside)
        self.juggleChallengeView.cameraSwitch.button.addTarget(self, action: #selector(cameraSwitchPressed), for: .touchUpInside)
        self.juggleChallengeView.findingBallView.progressBarView.setMaximumValue(self.model.framesTarget)
        var panGesture = UIPanGestureRecognizer()
        juggleChallengeView.foundBallView.keepyUpCounterView.isUserInteractionEnabled = true
        //        juggleChallengeView.isUserInteractionEnabled = true
        panGesture = UIPanGestureRecognizer(target: self, action: #selector(self.draggedView(_:)))
        panGesture.delegate = self
        juggleChallengeView.foundBallView.keepyUpCounterView.addGestureRecognizer(panGesture)
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(self.scalePiece(_:)))
        pinchGesture.delegate = self
        self.juggleChallengeView.foundBallView.keepyUpCounterView.addGestureRecognizer(pinchGesture)
        self.juggleChallengeView.foundBallView.setGoalValue(EventMessenger.shared.highScore)
    }


    
    func addScore(){
        EventMessenger.shared.addScore()

        self.juggleChallengeView.foundBallView.keepyUpCounterView.bounceAnimation()
        if EventMessenger.shared.pointsCounted == EventMessenger.shared.highScore {
            self.juggleChallengeView.foundBallView.keepyUpCounterView.showBackgroundCircle(color: .greenCircle)
        }
        self.juggleChallengeView.foundBallView.keepyUpCounterView.setScore(score: EventMessenger.shared.pointsCounted)
    }
    
    func setLastHeight(_ lastHeight: CGFloat){
        self.model.lastHeight = lastHeight
    }
    
    /// Hides the finding ball and found ball views. Run by the controller in the start of the app.
    func hideOtherViews(){
        self.juggleChallengeView.foundBallView.alpha = 0
        self.juggleChallengeView.findingBallView.alpha = 0
    }
   
    
    func updateStatusView(state: BallTrackingStatus){
        
        UIView.animate(withDuration: 0.4, delay: .zero, options: .curveEaseInOut, animations: { [self] in
            self.juggleChallengeView.missingBallView.alpha = (state == .notFound) ? 1.0 : 0.0
            self.juggleChallengeView.findingBallView.alpha = (state == .finding) ? 1.0 : 0.0
            self.juggleChallengeView.foundBallView.alpha = (state == .found) ? 1.0 : 0.0
            self.juggleChallengeView.bouncyBallView.alpha = (state != .found) ? 1.0 : 0.0
            
            
        })
        
    }
    
    @objc func backButtonPressed() {
        //MARK: Check frame rate drop
        let returnSwiftUIView = swiftUI_View
//        returnSwiftUIView.modalPresentationStyle = .fullScreen
//        returnSwiftUIView.modalTransitionStyle = .flipHorizontal
//        self.present(returnSwiftUIView, animated: true)
        returnSwiftUIView.view.window?.becomeKey()
        view.window?.rootViewController = returnSwiftUIView
        view.window?.makeKeyAndVisible()


        EventMessenger.shared.saveLastScore()
        EventMessenger.shared.saveHighScore()
        submitScore()
    }

    func submitScore(){
        let score = GKScore(leaderboardIdentifier: "juggling")
        score.value = Int64(EventMessenger.shared.lastScore)
        GKScore.report([score]){
            error in guard error == nil else{
                print(error?.localizedDescription ?? "")
                return
            }
            print("Score sent!")
        }
    }
    
    @objc func cameraSwitchPressed() {
        self.juggleChallengeView.visionDetectionView.switchCameraTapped()
    }
    
    @objc func resetButtonPressed() {

        self.juggleChallengeView.findingBallView.checkmarkView.setBackgroundColor(.gray)
        self.juggleChallengeView.foundBallView.keepyUpCounterView.pointCounterView.text = "0"
        self.juggleChallengeView.foundBallView.keepyUpCounterView.hideBackgroundCircle()
    }
    
    @objc func scalePiece(_ gestureRecognizer : UIPinchGestureRecognizer) {   guard gestureRecognizer.view != nil else { return }
        
        let keepyUpView: UIView = gestureRecognizer.view!
        var centerPoint: CGPoint

        centerPoint = keepyUpView.center
        
        if gestureRecognizer.state == .began || gestureRecognizer.state == .changed {
            print(gestureRecognizer.scale)

            //        keepyUpView.transform = CGAffineTransform(scaleX: gestureRecognizer.scale, y: gestureRecognizer.scale)
            let originalSize = keepyUpView.frame
            let newSize = originalSize.applying(keepyUpView.transform.scaledBy(x: gestureRecognizer.scale, y: gestureRecognizer.scale))

            if newSize.width > 140 {
                keepyUpView.transform = (keepyUpView.transform.scaledBy(x: gestureRecognizer.scale, y: gestureRecognizer.scale))
            }

            gestureRecognizer.scale = 1.0
        }
        
        keepyUpView.center = centerPoint
    }

    
    @objc func draggedView(_ sender:UIPanGestureRecognizer){
        let pointCounter = sender.view! as! KeepyUpCounterView
        let center = pointCounter.center
        
        self.view.bringSubviewToFront(pointCounter.hitbox)
        let translation = sender.translation(in: self.view)
        
        let distance :CGFloat = abs((center.x + translation.x) - self.model.pointCounterLastPosition.x) + abs((center.y + translation.y) - self.model.pointCounterLastPosition.y)
       
        pointCounter.center = pointCounter.center + translation
        if Int(distance) > 7 {
            UIImpactFeedbackGenerator(style: .rigid).impactOccurred()
            self.model.pointCounterLastPosition = pointCounter.center
        }
        
        sender.setTranslation(CGPoint.zero, in: self.view)
    }
    
}

extension JuggleChallengeController: VisionResultsDelegate {
    
    func updateOld (objectVerticalSize: CGFloat, currentHeight: CGFloat, confidence: CGFloat) {
        switch self.model.direction {
        case .upwards:
            if currentHeight > self.model.lastHeight + objectVerticalSize/6 {
                self.model.direction = .downwards
            }
        case .downwards:
            if currentHeight < self.model.lastHeight - objectVerticalSize/6 {
                self.model.direction = .upwards
                if (self.model.ballTrackingStatus == .found){
                    addScore()
                }
            }
        case .stopped:
            currentHeight > self.model.lastHeight + objectVerticalSize/7 ? (self.model.direction = .downwards) : (self.model.direction = .upwards)
        }
        
        self.juggleChallengeView.foundBallView.directionView.text = self.model.direction.rawValue.capitalized
        
        setLastHeight(currentHeight)
    }
    
    
    
    func updateDirectionStatus(objectVerticalSize: CGFloat, currentHeight: CGFloat, confidence: CGFloat) {
        updateGameleira(objectVerticalSize: objectVerticalSize, currentHeight: currentHeight, confidence: confidence)
    }
    
    func updateGameleira(objectVerticalSize: CGFloat, currentHeight: CGFloat, confidence: CGFloat) {
        
        let ballIsFound = self.model.ballTrackingStatus == .found
        
        guard ballIsFound else {return}
        
        self.model.trace.append(currentHeight)
        self.model.trace.remove(at: 0)
        
        let maxTraceDistance = abs(self.model.trace[0] - self.model.trace[3])
        
        guard (maxTraceDistance > objectVerticalSize/2) else {return}
                
        
        let goingDown = self.model.trace[0] < self.model.trace[1] && self.model.trace[1] < self.model.trace[2] && self.model.trace[2] < self.model.trace[3]
        
        let goingUp = self.model.trace[0] > self.model.trace[1] && self.model.trace[1] > self.model.trace[2] && self.model.trace[2] > self.model.trace[3]
        
        switch self.model.direction {
        case .upwards:
            if goingDown {
                self.model.direction = .downwards
            }
        case .downwards:
            if goingUp {
                self.model.direction = .upwards
                addScore()
                
            }
        case .stopped:
            currentHeight > self.model.lastHeight + objectVerticalSize/7 ? (self.model.direction = .downwards) : (self.model.direction = .upwards)
        }
        
        self.juggleChallengeView.foundBallView.directionView.text = self.model.direction.rawValue
        
        //            if goingUp || goingDown {
        //                setLastHeight(currentHeight)
        //            }
    }
    
    func updateUsingHalfBall(objectVerticalSize: CGFloat, currentHeight: CGFloat, confidence: CGFloat) {
        
            
            let ballIsFound = self.model.ballTrackingStatus == .found
            
            guard ballIsFound else {return}
            
            let minimumConfidence = 0.96
            
            let threshold = objectVerticalSize/2
            
            let goingUp = (currentHeight - self.model.lastHeight) < -threshold
            let goingDown = (currentHeight - self.model.lastHeight) > threshold
            
            let startingDirection: Direction = self.model.direction
            
        if startingDirection == .stopped {
            self.model.direction = .downwards
        }
        
        
        else if confidence > minimumConfidence{
            
            if goingDown {
                self.model.direction = .downwards
            }
            
            else if goingUp {
                self.model.direction = .upwards
            }
            
            self.juggleChallengeView.foundBallView.directionView.text = self.model.direction.rawValue
            
            if goingUp || goingDown {
                setLastHeight(currentHeight)
            }
            
            if self.model.direction == .upwards && startingDirection == .downwards {
                addScore()
            }
            
        }
        
    }
    
    func updateStatusView(_ amountOfResults: Int) {
        
        let framesToConfirm = Int(self.model.framesTarget + self.model.framesTarget/3)
        
        let ballIsBeingFound = self.model.framesWithBall > framesToConfirm/3 && self.model.framesWithBall < framesToConfirm + 20
        let ballNotFound = self.model.ballTrackingStatus != .found
        
        let resultsExist = amountOfResults > 0
        
        let ballIsFound = self.model.framesWithBall >= framesToConfirm + 20
        
        let ballIsLost = self.model.framesWithBall == 0
        // two behaviours, one before a ball is located, another when a ball has already been located
        
        // if it sees the ball, adds one, else, resets
        
        if ballNotFound {
            
            if resultsExist {
                self.model.framesWithBall += 1
            }
            
            else {
                self.model.framesWithBall = 0
                self.model.ballTrackingStatus = .notFound
                self.juggleChallengeView.findingBallView.progressBarView.animateProgress(newValue: 0)
                self.resetButtonPressed()
            }
            
            if ballIsBeingFound {
                
                let correctedValue:CGFloat = (CGFloat(self.model.framesWithBall) - CGFloat(framesToConfirm/3))
                
                let value: CGFloat = (self.model.framesWithBall > framesToConfirm) ? self.model.framesTarget : correctedValue
                
                let ballIsDetected =  self.model.framesWithBall == framesToConfirm
                
                if ballIsDetected {
                    UIView.animate(withDuration: 0.5, animations: {
                        self.juggleChallengeView.findingBallView.checkmarkView.setBackgroundColor(.greenCircle)
                    })
                }
                
                self.juggleChallengeView.findingBallView.progressBarView.animateProgress(newValue: value)
                self.model.ballTrackingStatus = .finding
            }
            else if ballIsFound {
                self.model.ballTrackingStatus = .found
            }
        }
        
        // second behaviour, ball has already been found
        else {
            
            if !resultsExist {
                self.model.framesWithBall -= 2
                if self.model.framesWithBall < 0 {self.model.framesWithBall = 0}
            }
            
            if ballIsLost {
                self.model.ballTrackingStatus = .notFound
                self.resetButtonPressed()
            }
        }
        
        // new loading view tests
        
        self.updateStatusView(state: self.model.ballTrackingStatus)
        
        
//        UIView.animate(withDuration: 0.6, delay: .zero,options: .curveEaseInOut, animations: {
//            self.juggleChallengeView.ballStatusView.text = self.model.ballTrackingStatus.rawValue
//            self.juggleChallengeView.ballStatusView.backgroundColor = self.model.ballTrackingStatus.color
//        })
    }
    
}


