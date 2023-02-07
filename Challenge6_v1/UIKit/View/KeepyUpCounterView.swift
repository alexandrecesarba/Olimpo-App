//
//  KeepyUpCounterView.swift
//  Object Detection Live Stream
//
//  Created by Pedro Peçanha on 30/01/23.
//

import Foundation
import UIKit


let circleRadius:CGFloat = 60
let sizeIncreaser:CGFloat = 40
var centerPoint: CGPoint = CGPoint(x: 0, y: 0)
let innerRadius: CGFloat = circleRadius + sizeIncreaser
let outerRadius: CGFloat = circleRadius + 2*sizeIncreaser
let pointCircleRadius: CGFloat = circleRadius

class KeepyUpCounterView: UIView {
    var circles: [UIView] {[backgroundCircle, outerCircle, innerCircle, pointCounterView, hitbox]}
    var visibleCircles: [UIView] {[outerCircle, innerCircle, pointCounterView]}
    
    var pointCounterView: UILabel = {
        let amountOfKeepyUps = UILabel()
        amountOfKeepyUps.font = UIFont.preferredFont(forTextStyle: .title1, compatibleWith: UITraitCollection(legibilityWeight: .bold))
        //        amountOfKeepyUps.font = UIFont.systemFont(ofSize: 15)
        amountOfKeepyUps.layer.masksToBounds = true
        amountOfKeepyUps.backgroundColor = UIColor.whiteCircle
        amountOfKeepyUps.frame = CGRect(x: 20, y: 40, width: circleRadius, height: circleRadius)
        amountOfKeepyUps.layer.cornerRadius = amountOfKeepyUps.frame.width/2
        amountOfKeepyUps.textColor = .pointColor
        amountOfKeepyUps.contentMode = .scaleToFill
        amountOfKeepyUps.adjustsFontSizeToFitWidth = false
        amountOfKeepyUps.adjustsFontForContentSizeCategory = false
        amountOfKeepyUps.textAlignment = .center
        amountOfKeepyUps.text = "0"
        return amountOfKeepyUps
    }()
    
    var innerCircle: UIView = createColoredCircle(color: .whiteCircle, radius: innerRadius)
    var outerCircle: UIView = createColoredCircle(color: .whiteCircle, radius: outerRadius)
    var backgroundCircle: UIView = createColoredCircle(color: .greenCircle, radius: 0,borderWidth: 0, isTransparent: true)
    var rightAnswerCircle: UIView = createColoredCircle(color: .whiteCircle, radius: outerRadius)
    var hitbox: UIView = createColoredCircle(color: UIColor.clear, radius: circleRadius + 40, borderWidth: 0, isTransparent: true)
    
    
    func repositionViews(point:CGPoint, translation: CGPoint){
        for circle in circles {
            circle.center = CGPoint(x: point.x + translation.x, y: point.y + translation.y)
        }
        centerPoint = CGPoint(x: point.x + translation.x, y: point.y + translation.y)
    }
    
    func setScore(score: Int) {
        pointCounterView.text = String(score)
    }
    
    func centerViews(){
        for circle in circles {
            circle.center = UIScreen.main.bounds.center
        }
        centerPoint = UIScreen.main.bounds.center
    }
    
    func addRecognizer(_ recognizer: UIPanGestureRecognizer, label: UILabel){
        label.addGestureRecognizer(recognizer)
    }
    
    func hideBackgroundCircle(){
        backgroundCircle.alpha = 0
    }
    
    func showBackgroundCircle(color: UIColor){
        
        UIView.animate(withDuration: 0.45, delay: .zero, animations: { [self] in
            backgroundCircle.backgroundColor = .greenCircle.withAlphaComponent(0.7)
            backgroundCircle.frame.size.width = outerRadius
            backgroundCircle.frame.size.height = outerRadius
            backgroundCircle.center = outerCircle.center
            backgroundCircle.layer.cornerRadius = backgroundCircle.frame.width/2
            backgroundCircle.alpha = 1
        })
        backgroundCircle.center = outerCircle.center
    }
    func paintBalls(color: UIColor){
        for circle in visibleCircles {
            circle.backgroundColor = color
            if circle == pointCounterView{
                circle.backgroundColor = color
            }
            
        }
    }
    
    func animateBall(ball: UIView){
        let originalSize =  ball.frame.size
        UIView.animate(withDuration: 0.1, delay: .zero, options: .curveEaseInOut ,animations: {
            ball.frame.size.width *= 1.6
            ball.frame.size.height *= 1.6
            ball.layer.cornerRadius = ball.frame.width/2
            ball.center = centerPoint
        }, completion: { _ in
            UIView.animate(withDuration: 0.2, delay: .zero, options: .curveEaseInOut ,animations: {
                ball.center = centerPoint
                ball.frame.size.width = originalSize.width
                ball.frame.size.height = originalSize.height
                ball.layer.cornerRadius = ball.frame.width/2
                ball.center = centerPoint
            })
        })
    
        
        
    }
    
    func bounceAnimation(){
        
        let defaultDuration = 0.45
        let expandConstant:CGFloat = 1.6
        
        UIView.animate(withDuration: defaultDuration, delay: .zero, options: .curveEaseInOut ,animations: {
            self.outerCircle.frame.size.width *= expandConstant
            self.outerCircle.frame.size.height *= expandConstant
            self.outerCircle.layer.cornerRadius = self.outerCircle.frame.width/2
            self.outerCircle.center = centerPoint
            self.backgroundCircle.frame.size.width *= expandConstant
            self.backgroundCircle.frame.size.height *= expandConstant
            self.backgroundCircle.layer.cornerRadius = self.outerCircle.frame.width/2
            self.backgroundCircle.center = centerPoint
        })
        
        UIView.animate(withDuration: defaultDuration/2, delay: .zero, options: .curveEaseInOut ,animations: {
            self.innerCircle.frame.size.width *= expandConstant
            self.innerCircle.frame.size.height *= expandConstant
            self.innerCircle.layer.cornerRadius = self.innerCircle.frame.width/2
            self.innerCircle.center = centerPoint
        })
        
        UIView.animate(withDuration: defaultDuration/3, delay: .zero, options: .curveEaseInOut ,animations: {
//            self.pointCounterView.frame.size.width *= 1.6
//            self.pointCounterView.frame.size.height *= 1.6
            self.pointCounterView.transform = CGAffineTransform(scaleX: expandConstant, y: expandConstant)
//            self.pointCounterView.layer.cornerRadius = self.pointCounterView.frame.width * 1.6/2
            self.pointCounterView.center = centerPoint
        }, completion: { _ in
            //MARK: VOLTA
            UIView.animate(withDuration: defaultDuration, delay: .zero, options: .curveEaseInOut ,animations: {
                self.outerCircle.frame.size = CGSize(width: outerRadius, height: outerRadius)
                self.outerCircle.layer.cornerRadius = self.outerCircle.frame.width/2
                self.outerCircle.center = centerPoint
                
                    self.backgroundCircle.frame.size = CGSize(width: outerRadius, height: outerRadius)
                    self.backgroundCircle.layer.cornerRadius = self.outerCircle.frame.width/2
                    self.backgroundCircle.center = centerPoint
                
            })
            
            UIView.animate(withDuration: defaultDuration/2, delay: .zero, options: .curveEaseInOut ,animations: {
                self.innerCircle.frame.size = CGSize(width: innerRadius, height: innerRadius)
                self.innerCircle.layer.cornerRadius = self.innerCircle.frame.width/2
                self.innerCircle.center = centerPoint
            })
            
            UIView.animate(withDuration: defaultDuration/3, delay: .zero, options: .curveEaseInOut ,animations: {
//                self.pointCounterView.frame.size = CGSize(width: pointCircleRadius, height: pointCircleRadius)
                self.pointCounterView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
//                self.pointCounterView.layer.cornerRadius = self.pointCounterView.frame.width/2
                self.pointCounterView.center = centerPoint
            })
            
        })
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.centerViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

func createColoredCircle(color: UIColor, radius: CGFloat = circleRadius, borderWidth:CGFloat = 1, isTransparent:Bool = false)->UILabel {
        let circle: UILabel = UILabel()
        circle.frame = CGRect(x: 20, y: 40, width: radius, height: radius)
        circle.layer.borderWidth = borderWidth
        circle.layer.masksToBounds = true
        circle.contentMode = .scaleToFill
        circle.layer.cornerRadius = circle.frame.width/2
    circle.layer.borderColor = CGColor(red: 255, green: 255, blue: 255, alpha: 1.0)
        print(color)
        if (isTransparent) {
            circle.backgroundColor = color.withAlphaComponent(0)
        }
        else {
            circle.backgroundColor = color.withAlphaComponent(0.2)
        }
        circle.isUserInteractionEnabled = true
        return circle
}


