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
    let cameraFeedView = CameraFeedView()
    let visionDetectionView = VisionDetectionView()
    let bouncyBallView = BouncyBallView()
    let missingBallView = MissingBallView()
    let findingBallView = FindingBallView()
    let foundBallView = FoundBallView()
    
    func fixBufferSize() {
        visionDetectionView.bufferSize = cameraFeedView.bufferSize
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
        addSubview(cameraSwitch)
        
        visionDetectionView.translatesAutoresizingMaskIntoConstraints = false
        visionDetectionView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        visionDetectionView.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        fixBufferSize()
        foundBallView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        foundBallView.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        findingBallView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        findingBallView.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        missingBallView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        missingBallView.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        cameraSwitch.widthAnchor.constraint(equalToConstant: 60).isActive = true
        cameraSwitch.heightAnchor.constraint(equalToConstant: 60).isActive = true
                        
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: self.cameraSwitch, attribute: .bottom, relatedBy: .equal, toItem: self.safeAreaLayoutGuide, attribute: .bottom, multiplier: 1, constant: -15),
            NSLayoutConstraint(item: self.cameraSwitch, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 0.95, constant: 0)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) f total")
    }
    
}
