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
    let ballStatusView = BallStatusView()
    let resetButtonView = ResetButtonView()
    let keepyUpCounterView = KeepyUpCounterView()
    let objectDetectionView = CameraFeedView(frame: UIScreen.main.bounds)
    
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        objectDetectionView.setupAVCapture()
        objectDetectionView.startCaptureSession()
        addSubview(objectDetectionView)
        addSubview(targetView)
        addSubview(directionView)
        addSubview(ballStatusView)
        addSubview(resetButtonView)
        for circle in keepyUpCounterView.circles{
            addSubview(circle)
        }
        
        
        targetView.widthAnchor.constraint(equalToConstant: 120).isActive = true
        targetView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        directionView.widthAnchor.constraint(equalToConstant: 120).isActive = true
        directionView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        resetButtonView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        resetButtonView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.maxX - 30).isActive = true
        ballStatusView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        ballStatusView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        
        
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: self.targetView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 0.25, constant: 0),
            NSLayoutConstraint(item: self.targetView, attribute: .top, relatedBy: .equal, toItem: self.safeAreaLayoutGuide, attribute: .top, multiplier: 0.8, constant: 0),
            NSLayoutConstraint(item: self.directionView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 0.75, constant: 0),
            NSLayoutConstraint(item: self.directionView, attribute: .top, relatedBy: .equal, toItem: self.safeAreaLayoutGuide, attribute: .top, multiplier: 0.8, constant: 0),
            NSLayoutConstraint(item: self.resetButtonView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: self.resetButtonView, attribute: .bottom, relatedBy: .equal, toItem: self.safeAreaLayoutGuide, attribute: .bottom, multiplier: 1, constant: -10),
            NSLayoutConstraint(item: self.ballStatusView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 0.5, constant: 0),
            NSLayoutConstraint(item: self.ballStatusView, attribute: .top, relatedBy: .equal, toItem: self.targetView, attribute: .bottom, multiplier: 1, constant: 20)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) f total")
    }
    
}
