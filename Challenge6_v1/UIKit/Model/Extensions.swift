//
//  Extensions.swift
//  Object Detection Live Stream
//
//  Created by Pedro Peçanha on 01/02/23.
//

import Foundation
import UIKit

extension CGRect {
    var customCenter:CGPoint {
        return CGPoint(x: self.midX, y: self.midY)
    }
    
    var area: CGFloat {
        return self.height * self.width
    }
}

extension UIColor {
    static var whiteCircle = UIColor(named: "whiteCircle")!
    static var greenCircle = UIColor(named: "greenCircle")!
    static var pointColor = UIColor(named: "pointColor")!
    static var alertOrange = UIColor(named: "alertOrange")!
    
    /// Not working.
    static func getMixedColor(color1: UIColor, color2: UIColor)-> UIColor{
        
        var colorRGBA1: (CGFloat, CGFloat, CGFloat, CGFloat) = (0,0,0,0)
        var colorRGBA2: (CGFloat, CGFloat, CGFloat, CGFloat) = (0,0,0,0)
        
        color1.getRed(&colorRGBA1.0, green: &colorRGBA1.1, blue: &colorRGBA1.2, alpha: &colorRGBA1.3)
        color2.getRed(&colorRGBA2.0, green: &colorRGBA2.1, blue: &colorRGBA2.2, alpha: &colorRGBA2.3)
    
        colorRGBA1.0 = colorRGBA1.0 * 255
        colorRGBA1.1 = colorRGBA1.1 * 255
        colorRGBA1.2 = colorRGBA1.2 * 255
        
        colorRGBA2.0 = colorRGBA2.0 * 255
        colorRGBA2.1 = colorRGBA2.1 * 255
        colorRGBA2.2 = colorRGBA2.2 * 255
        
        
        let alpha = 1 - (1 - colorRGBA2.3) * (1 - colorRGBA1.3); // alpha
        let red = CGFloat((colorRGBA2.0 * colorRGBA2.3 / colorRGBA1.3) + (colorRGBA1.0 * colorRGBA1.3 * (1 - colorRGBA2.3) / colorRGBA1.3)); // red
        let green = CGFloat((colorRGBA2.1 * colorRGBA2.3 / colorRGBA1.3) + (colorRGBA1.1 * colorRGBA1.3 * (1 - colorRGBA2.3) / colorRGBA1.3)); // green
        let blue = CGFloat((colorRGBA2.2 * colorRGBA2.3 / colorRGBA1.3) + (colorRGBA1.2 * colorRGBA1.3 * (1 - colorRGBA2.3) / colorRGBA1.3)); // blue
        
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: alpha)
    }
}

extension UIFont {
    static func getRoundedFont(size: CGFloat, weight: UIFont.Weight)-> UIFont{
        let systemFont = UIFont.systemFont(ofSize: size, weight: .semibold)
        let roundedFont: UIFont
        
        if let descriptor = systemFont.fontDescriptor.withDesign(.rounded)?.addingAttributes([.traits: [
            UIFontDescriptor.TraitKey.weight: weight]
          ]) {
            roundedFont = UIFont(descriptor: descriptor, size: size)
        } else {
            roundedFont = systemFont
        }
        roundedFont.withSize(size)
        return roundedFont
    }
}

extension CGPoint {
    func distance(to: CGPoint) -> CGFloat {
        return (self.x - to.x) * (self.x - to.x) + (self.y - to.y) * (self.y - to.y)
    }
    
    static func add(_ first: CGPoint, _ second: CGPoint)-> CGPoint {
        return CGPoint (x: (first.x + second.x),y: (first.y + second.y))
    }
    
}
