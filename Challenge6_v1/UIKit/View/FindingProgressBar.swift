//
//  FindingProgressBar.swift
//  Challenge6_v1
//
//  Created by Pedro Peçanha on 14/02/23.
//

import Foundation
import UIKit
import CoreFoundation

class FindingProgressBar: UIView {
    
    private let backgroundBar = Bar()
    private let foregroundBar = Bar()
    
    /// Size of the bar. Goes from 0.0 to 1.0
    let size: CGFloat = 0.9
    
    var maximumValue:CGFloat = 0
    
    var foregroundBarConstraint: NSLayoutConstraint? = nil
    
    
    init(fromFrame frame:CGRect, usingMaximumValueAs: CGFloat, barSize: CGFloat = 0.8, color : UIColor = .red){
        super.init(frame: frame)
        
        setup(frame: frame,using: usingMaximumValueAs, color: color)
    }
    
    private func setup(frame:CGRect, using:CGFloat, color: UIColor){
        self.setup(frame: frame, color: color)
        //TODO: Use the maximum value
        
        self.backgroundBar.layer.borderWidth = 1
        self.backgroundBar.layer.borderColor = UIColor.whiteCircle.cgColor
    }
    
    override init(frame:CGRect){
        super.init(frame: frame)
        
//        setup(frame: frame)
    }
    
    private func setup(frame: CGRect, color: UIColor) {
        //super.init(frame: frame)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(backgroundBar)
        addSubview(foregroundBar)
        
        
        
        backgroundBar.setColor(.gray)
        setColor(color)
        
        let foregroundBarConstraint = foregroundBar.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0)
        self.foregroundBarConstraint = foregroundBarConstraint
        self.foregroundBarConstraint?.isActive = true
        
        foregroundBar.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
//        foregroundBar.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        backgroundBar.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: size).isActive = true
        backgroundBar.heightAnchor.constraint(equalTo: self.foregroundBar.heightAnchor).isActive = true
//        backgroundBar.centerYAnchor.constraint(equalTo: self.foregroundBar.centerYAnchor).isActive = true
        
        NSLayoutConstraint.activate([
            
            NSLayoutConstraint(item: foregroundBar, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1.0 - size, constant: 0)
            
        ])
        
        backgroundBar.leadingAnchor.constraint(equalTo: self.foregroundBar.leadingAnchor).isActive = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setMaximumValue (_ value: CGFloat){
        self.maximumValue = value
    }
    
    func getForegroundSize (value: CGFloat) -> CGFloat {
        
        return value * size / maximumValue
        
    }
    
    func setColor (_ color: UIColor) {
        foregroundBar.backgroundColor = color
    }
    
    func animateProgress(newValue: CGFloat){
        print("entered async")
      
        let newValue = getForegroundSize(value: newValue)
        let newConstraint = foregroundBar.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: newValue)

            UIView.animate(withDuration: 0.5, delay: 0, animations: { [self] in
                
                self.foregroundBarConstraint?.isActive = false
                newConstraint.isActive = true
                 self.layoutIfNeeded()
                })
        
        
        self.foregroundBarConstraint = newConstraint
    }
    
    private class Bar: UIView {
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            self.translatesAutoresizingMaskIntoConstraints = false
            self.backgroundColor = .red
            self.roundCorners()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        func roundCorners(){
            self.layer.cornerRadius = 20
        }
        
        func setColor (_ color: UIColor) {
            self.backgroundColor = color
        }
        
        //TODO: this view
        
    }

    
}
