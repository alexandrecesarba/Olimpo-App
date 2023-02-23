//
//  VisionResultsDelegate.swift
//  Challenge6_v1
//
//  Created by Pedro Peçanha on 06/02/23.
//

import Foundation


protocol VisionResultsDelegate: AnyObject {
    func updateStatusView (_ amountOfResults: Int)
    func updateDirectionStatus (objectVerticalSize: CGFloat, currentHeight: CGFloat, confidence: CGFloat)
    func isTouchingFloor (objectVerticalSize: CGFloat, currentHeight: CGFloat, floorLevel: CGFloat)
}
