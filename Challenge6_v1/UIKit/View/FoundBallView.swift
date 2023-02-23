//
//  FoundBallView.swift
//  Challenge6_v1
//
//  Created by Pedro Peçanha on 20/02/23.
//

import Foundation
import UIKit

class FoundBallView: UIView {
    
    /// Green circle displaying the user's current target.
    let userGoalView = UserGoalView()
    
    /// This is a debug view. Should be removed in production.
    let directionView = RoundedLabelView.create(name: "", fontSize: 30)
    
    /// This is a debug view. Should be removed in production.
    let resetButtonView = ResetButtonView()
    
    /// Circular, moveable and resizable counter displayed on screen.
    let keepyUpCounterView = KeepyUpCounterView()
    
    /// Array that contains all views that need to have custom constraints.
    lazy var views: [UIView] =  [userGoalView, directionView, resetButtonView]
    
    override func layoutSubviews() {
        keepyUpCounterViewConfiguration()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        for view in views {
            addSubview(view)
        }
        addSubview(keepyUpCounterView)
        
        enableConstraints()
        directionViewConstraints()
        resetButtonConstraints()
        userGoalViewConstraints()
        self.backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func enableConstraints() {
        self.translatesAutoresizingMaskIntoConstraints = false
        for view in views {
            view.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    func keepyUpCounterViewConfiguration() {
        keepyUpCounterView.frame = CGRect(x: self.frame.midX - 70, y: self.frame.midY - 70, width: 140, height: 140)
    }
    
    func directionViewConstraints() {
        directionView.widthAnchor.constraint(equalToConstant: 120).isActive = true
        directionView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: self.directionView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 0.25, constant: 0),
            NSLayoutConstraint(item: self.directionView, attribute: .top, relatedBy: .equal, toItem: self.safeAreaLayoutGuide, attribute: .top, multiplier: 0.9, constant: 0)
        ])
    }
    
    func resetButtonConstraints() {
        resetButtonView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        resetButtonView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.45).isActive = true
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: self.resetButtonView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: self.resetButtonView, attribute: .bottom, relatedBy: .equal, toItem: self.safeAreaLayoutGuide, attribute: .bottom, multiplier: 1, constant: -10)
        ])
    }
    
    func userGoalViewConstraints() {
        userGoalView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.3).isActive = true
        userGoalView.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.3).isActive = true
        userGoalView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 30).isActive = true
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: self.userGoalView, attribute: .trailing, relatedBy: .equal, toItem: self.layoutMarginsGuide, attribute: .trailing, multiplier: 0.95, constant: 0)
        ])
    }
    
    func setGoalValue(_ value: Int) {
        self.userGoalView.setGoalValue(value)
    }
    
}
