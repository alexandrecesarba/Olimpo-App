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
    
    let backgroundBar = Bar()
    let foregroundBar = Bar()
    
    /// Size of the bar. Goes from 0.0 to 1.0
    let size: CGFloat = 0.8
    
    var maximumValue:CGFloat = 10
    
    var foregroundBarConstraint: NSLayoutConstraint? = nil
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(backgroundBar)
        addSubview(foregroundBar)
        
        
        
        backgroundBar.setColor(.gray)
        
        let foregroundBarConstraint = foregroundBar.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: size/2)
        self.foregroundBarConstraint = foregroundBarConstraint
        self.foregroundBarConstraint?.isActive = true
        
        foregroundBar.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.05).isActive = true
        foregroundBar.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        backgroundBar.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: size).isActive = true
        backgroundBar.heightAnchor.constraint(equalTo: self.foregroundBar.heightAnchor).isActive = true
        backgroundBar.centerYAnchor.constraint(equalTo: self.foregroundBar.centerYAnchor).isActive = true
        
        NSLayoutConstraint.activate([
            
            NSLayoutConstraint(item: foregroundBar, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1.0 - size, constant: 0)
            
        ])
        
        backgroundBar.leadingAnchor.constraint(equalTo: self.foregroundBar.leadingAnchor).isActive = true
        //        animateProgress()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setMaximumValue (_ value: CGFloat){
        self.maximumValue = value
    }
    
    func getForegroundSize (currentValue: CGFloat) -> CGFloat {
        
        return currentValue * size / maximumValue
        
    }
    
    func animateProgress(){
        print("entered async")
      
        let newConstraint = foregroundBar.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: size - 0.1)

        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0, execute: {
            UIView.animate(withDuration: 0.5, delay: 3.0, animations: { [self] in
                
                self.foregroundBarConstraint?.isActive = false
                newConstraint.isActive = true
                 self.layoutIfNeeded()
                })
        })
        
        
    }
    
}

class Bar: UIView {
    
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
