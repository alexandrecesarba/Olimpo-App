//
//  BouncingBallUIView.swift
//  Challenge6_v1
//
//  Created by Pedro Peçanha on 11/03/23.
//

import Foundation
import UIKit

var sinConstant: Double = 0.0


///Animating the ball without going to SpriteKit to do so.
class BouncingBallView: UIView {
    
    var ballImage: UIImageView = UIImageView(image: UIImage(named: "ball_inverted"))
    var topConstraint: NSLayoutConstraint? = nil
    
    override func layoutSubviews() {
        self.layer.cornerRadius = self.frame.height/2
        self.ballImage.layer.cornerRadius = self.frame.height/2
    }

    convenience init(ballImage: UIImageView) {
        self.init()
        self.translatesAutoresizingMaskIntoConstraints = false
        self.ballImage = ballImage
        addSubview(self.ballImage)
        ballImageConstraints()
        ballImageConfiguration()
        self.backgroundColor = .red
       
    }
    
    private func ballImageConstraints() {
        self.ballImage.translatesAutoresizingMaskIntoConstraints = false
        self.ballImage.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        topConstraint = NSLayoutConstraint(item: self.ballImage, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 0.5, constant: 0)
        topConstraint?.isActive = true
        self.ballImage.heightAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        self.ballImage.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.ballImage.contentMode = .scaleAspectFit
    }
    
    private func ballImageConfiguration() {
        ballImage.backgroundColor = .green
    }
    
    private func sinFunction(x: Double) -> Double {
        let amplitude = 0.35 // range of variation (1.0 - 0.3 = 0.7, so we use 0.35 as amplitude to center around 0.65)
        let frequency = 1.0 // frequency of oscillation
        let phaseShift = 0.0 // phase shift of the function

        let y = amplitude * sin(frequency * x + phaseShift) + 0.65 // shifting the function upwards by 0.65 to make it vary from 0.3 to 1.0
        
        return y
    }

    
    func animateBallBounce() {
        
        print(self.sinFunction(x: (Date().timeIntervalSinceReferenceDate / 2.0) * 100.0))
        let newConstraint = NSLayoutConstraint(item: self.ballImage, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 0.1, constant: 0)
        self.topConstraint?.isActive = false
        newConstraint.isActive = true
        UIView.animate(withDuration: 0.5, delay: 4, options: [.repeat, .autoreverse], animations: { [self] in
            self.layoutIfNeeded()
            self.topConstraint = newConstraint
            })

    }
    
}
