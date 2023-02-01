//
//  Extensions.swift
//  Object Detection Live Stream
//
//  Created by Pedro Peçanha on 01/02/23.
//

import Foundation
import UIKit

extension CGRect {
    var center:CGPoint {
        return CGPoint(x: self.midX, y: self.midY)
    }
}

extension UIColor {
    static var whiteCircle = UIColor(named: "whiteCircle")!
    static var greenCircle = UIColor(named: "greenCircle")!
    static var pointColor = UIColor(named: "pointColor")!
}

extension CGPoint {
    func distance(to: CGPoint) -> CGFloat {
        return (self.x - to.x) * (self.x - to.x) + (self.y - to.y) * (self.y - to.y)
    }
}
