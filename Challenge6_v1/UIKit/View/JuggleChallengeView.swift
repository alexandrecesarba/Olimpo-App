//
//  JuggleChallengeView.swift
//  Challenge6_v1
//
//  Created by Pedro Peçanha on 03/02/23.
//

import Foundation
import UIKit

class JuggleChallengeView: UIView {
    
    let targetView = RoundedLabelView.create(name: "")
    let directionView = RoundedLabelView.create(name: "")
    let cameraSwitch = CameraSwitchView()
    let ballStatusView = BallStatusView()
    let resetButtonView = ResetButtonView()
    let keepyUpCounterView = KeepyUpCounterView()
    let cameraFeedView = CameraFeedView(frame: UIScreen.main.bounds)
    let visionDetectionView = VisionDetectionView(frame: UIScreen.main.bounds)
    let bouncyBallView = BouncyBallView()
    let missingBallView = MissingBallView()
    let findingBallView = FindingBallView()
    let progressBar = FindingProgressBar()
    
    
    var infoViews: [UIView] {[targetView, directionView, ballStatusView, resetButtonView, keepyUpCounterView, cameraFeedView]}
    
    
    func setupEverything() {
        cameraFeedView.setupAVCapture()
        visionDetectionView.bufferSize = cameraFeedView.bufferSize
        visionDetectionView.setupAVCapture()
        // setup Vision parts
        visionDetectionView.setupLayers()
        visionDetectionView.updateLayerGeometry()
        print(visionDetectionView.setupVision() ?? "no error")
        
        // start the capture
        visionDetectionView.startCaptureSession()
    }
    
    override func willMove(toSuperview newSuperview: UIView?) {
        keepyUpCounterView.frame = CGRect(x: self.frame.midX - 70, y: self.frame.midY - 70, width: 140, height: 140)
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupEverything()
//        addSubview(cameraFeedView)
        
        addSubview(visionDetectionView)
        addSubview(targetView)
        addSubview(directionView)
        addSubview(ballStatusView)
        addSubview(resetButtonView)
        addSubview(keepyUpCounterView)
        addSubview(bouncyBallView)
        addSubview(missingBallView)
        addSubview(findingBallView)
        addSubview(cameraSwitch)
        addSubview(progressBar)
        
        
        keepyUpCounterView.translatesAutoresizingMaskIntoConstraints = true

        progressBar.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        progressBar.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        progressBar.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        progressBar.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        cameraSwitch.widthAnchor.constraint(equalToConstant: 60).isActive = true
        cameraSwitch.heightAnchor.constraint(equalToConstant: 60).isActive = true
        targetView.widthAnchor.constraint(equalToConstant: 120).isActive = true
        targetView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        directionView.widthAnchor.constraint(equalToConstant: 120).isActive = true
        directionView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        resetButtonView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        resetButtonView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.45).isActive = true
        ballStatusView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        ballStatusView.widthAnchor.constraint(equalToConstant: 200).isActive = true

        
        
        progressBar.animateProgress()
        
        cameraSwitch.layer.cornerRadius = cameraSwitch.frame.height/2
        
        
        
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: self.targetView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 0.25, constant: 0),
            NSLayoutConstraint(item: self.targetView, attribute: .top, relatedBy: .equal, toItem: self.safeAreaLayoutGuide, attribute: .top, multiplier: 0.8, constant: 0),
            NSLayoutConstraint(item: self.directionView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 0.75, constant: 0),
            NSLayoutConstraint(item: self.directionView, attribute: .top, relatedBy: .equal, toItem: self.safeAreaLayoutGuide, attribute: .top, multiplier: 0.8, constant: 0),
            NSLayoutConstraint(item: self.resetButtonView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: self.resetButtonView, attribute: .bottom, relatedBy: .equal, toItem: self.safeAreaLayoutGuide, attribute: .bottom, multiplier: 1, constant: -10),
            NSLayoutConstraint(item: self.ballStatusView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 0.5, constant: 0),
            NSLayoutConstraint(item: self.ballStatusView, attribute: .top, relatedBy: .equal, toItem: self.targetView, attribute: .bottom, multiplier: 1, constant: 20),
            NSLayoutConstraint(item: self.cameraSwitch, attribute: .bottom, relatedBy: .equal, toItem: self.safeAreaLayoutGuide, attribute: .bottom, multiplier: 1, constant: -15),
            NSLayoutConstraint(item: self.cameraSwitch, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 0.95, constant: 0)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) f total")
    }
    
}
