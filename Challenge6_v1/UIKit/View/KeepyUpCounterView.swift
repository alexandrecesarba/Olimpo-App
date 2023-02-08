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
//var centerPoint: CGPoint = CGPoint(x: 0, y: 0)
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
        amountOfKeepyUps.frame = CGRect(x: 0, y: 0, width: circleRadius, height: circleRadius)
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
    var backgroundCircle: UIView = createColoredCircle(color: .greenCircle, radius: 0, borderWidth: 0, isTransparent: true)
    var rightAnswerCircle: UIView = createColoredCircle(color: .whiteCircle, radius: outerRadius)
    var hitbox: UIView = createColoredCircle(color: UIColor.clear, radius: circleRadius + 40, borderWidth: 0, isTransparent: true)
    
    
//    func repositionViews(point:CGPoint, translation: CGPoint){
//        for circle in circles {
//            circle.center = CGPoint(x: point.x + translation.x, y: point.y + translation.y)
//        }
////        centerPoint = CGPoint(x: point.x + translation.x, y: point.y + translation.y)
//    }
    
    func setScore(score: Int) {
        pointCounterView.text = String(score)
    }
    
    func centerViews(){
        for circle in circles {
            circle.center = outerCircle.center
        }
    }
    
    func addRecognizer(_ recognizer: UIPanGestureRecognizer, label: UILabel){
        label.addGestureRecognizer(recognizer)
    }
    
    func hideBackgroundCircle(){
        backgroundCircle.alpha = 0
        backgroundCircle.frame.size.width = 0
        backgroundCircle.frame.size.height = 0
    }
    
    func showBackgroundCircle(color: UIColor){
        
        UIView.animate(withDuration: 0.45, delay: .zero, animations: { [self] in
            backgroundCircle.backgroundColor = .greenCircle.withAlphaComponent(0.7)
            backgroundCircle.frame.size.width = outerRadius
            backgroundCircle.frame.size.height = outerRadius
//            backgroundCircle.center = outerCircle.center + CGPoint(x: outerCircle.center.x/2, y: outerCircle.center.y/2)
            backgroundCircle.layer.cornerRadius = backgroundCircle.frame.width/2
            backgroundCircle.alpha = 1
        })
        backgroundCircle.center = outerCircle.center
    }
    
    func bounceAnimation(){
        
        let defaultDuration = 0.45
        let expandConstant:CGFloat = 1.6
        
        UIView.animate(withDuration: defaultDuration, delay: .zero, options: .curveEaseInOut ,animations: {

            self.outerCircle.transform = CGAffineTransform(scaleX: expandConstant, y: expandConstant)
            self.backgroundCircle.transform = CGAffineTransform(scaleX: expandConstant, y: expandConstant)
 
        })
        
        UIView.animate(withDuration: defaultDuration/2, delay: .zero, options: .curveEaseInOut ,animations: {
            self.innerCircle.transform = CGAffineTransform(scaleX: expandConstant, y: expandConstant)

        })
        
        UIView.animate(withDuration: defaultDuration/3, delay: .zero, options: .curveEaseInOut ,animations: {

            self.pointCounterView.transform = CGAffineTransform(scaleX: expandConstant, y: expandConstant)

        }, completion: { _ in
            //MARK: VOLTA
            UIView.animate(withDuration: defaultDuration, delay: .zero, options: .curveEaseInOut ,animations: {

                self.outerCircle.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                self.backgroundCircle.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)

                
            })
            
            UIView.animate(withDuration: defaultDuration/2, delay: .zero, options: .curveEaseInOut ,animations: {
                self.innerCircle.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            })
            
            UIView.animate(withDuration: defaultDuration/3, delay: .zero, options: .curveEaseInOut ,animations: {

                self.pointCounterView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)

            })
            
        })
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.centerViews()
        for circle in circles {
            addSubview(circle)
            circle.isUserInteractionEnabled = true
        }
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .red
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

func createColoredCircle(color: UIColor, radius: CGFloat = circleRadius, borderWidth:CGFloat = 1, isTransparent:Bool = false)->UILabel {
        let circle: UILabel = UILabel()
        circle.frame = CGRect(x: 0, y: 0, width: radius, height: radius)
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


