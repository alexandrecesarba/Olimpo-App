//
//  JuggleChallengeView.swift
//  Challenge6_v1
//
//  Created by Pedro Peçanha on 03/02/23.
//

import Foundation
import UIKit

class JuggleChallengeView: UIView {
    
    let cameraSwitch = CameraSwitchView()
    let cameraFeedView = CameraFeedView(frame: UIScreen.main.bounds)
    let visionDetectionView = VisionDetectionView(frame: UIScreen.main.bounds)
    let backButtonView = BackButtonView()
    let bouncyBallView = BouncyBallView()
    let missingBallView = MissingBallView()
    let findingBallView = FindingBallView()
    let foundBallView = FoundBallView()
//    let bouncingBallView = BouncingBallView(ballImage: UIImageView(image: UIImage(named: "ball_inverted")))
    
    
    func fixBufferSize() {
        visionDetectionView.bufferSize = cameraFeedView.bufferSize
    }
    
    func setupVisionCamera() {
        cameraFeedView.setupAVCapture()
       
        //        visionDetectionView.setupAVCapture()
        // setup Vision parts

                
                // start the capture
        cameraFeedView.startCaptureSession()
        fixBufferSize()
        visionDetectionView.setupAVCapture()
       
        //        visionDetectionView.setupAVCapture()
        // setup Vision parts
        visionDetectionView.setupLayers()
        visionDetectionView.updateLayerGeometry()
        print(visionDetectionView.setupVision() ?? "no error")
                // start the capture
        visionDetectionView.startCaptureSession()
        
    }
    
    override func willMove(toSuperview newSuperview: UIView?) {
//        keepyUpCounterView.frame = CGRect(x: self.frame.midX - 70, y: self.frame.midY - 70, width: 140, height: 140)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        addSubview(visionDetectionView)
        addSubview(bouncyBallView)
        addSubview(missingBallView)
        addSubview(findingBallView)
        addSubview(foundBallView)
//        addSubview(bouncingBallView)
        addSubview(cameraSwitch)
        addSubview(backButtonView)
        setupVisionCamera()
        fixBufferSize()


        // MARK: View constraints declaration
        foundBallView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        foundBallView.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        findingBallView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        findingBallView.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        missingBallView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        missingBallView.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        cameraSwitch.widthAnchor.constraint(equalToConstant: 60).isActive = true
        cameraSwitch.heightAnchor.constraint(equalToConstant: 60).isActive = true
        backButtonView.widthAnchor.constraint(equalToConstant: 30).isActive = true
        backButtonView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        backButtonView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        backButtonView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 30).isActive = true
        
//        bouncingBallView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.3).isActive = true
//        bouncingBallView.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.3).isActive = true
//        bouncingBallView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
//        bouncingBallView.topAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: self.cameraSwitch, attribute: .bottom, relatedBy: .equal, toItem: self.safeAreaLayoutGuide, attribute: .bottom, multiplier: 1, constant: -15),
            NSLayoutConstraint(item: self.cameraSwitch, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 0.95, constant: 0)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) f total")
    }
    
}
