//
//  UserGoalView.swift
//  Challenge6_v1
//
//  Created by Pedro Peçanha on 16/02/23.
//

import Foundation
import UIKit

class UserGoalView: UIView {
    let goalNumberView = UILabel()
    let goalTextView = UILabel()
    var goalValue = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func layoutSubviews() {
        setupBackground()
    }
    
    init(frame: CGRect, goalValue: Int){
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        addSubview(goalTextView)
        addSubview(goalNumberView)
        setGoalValue(goalValue)
        goalTextConfiguration()
        goalNumberConfiguration()
        goalTextConstraints()
        goalNumberConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupBackground(){
//        self.backgroundColor = .greenCircle
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.whiteCircle.cgColor
        self.layer.masksToBounds = true
        print(bounds)
        print(frame)
        self.layer.cornerRadius = bounds.size.width/2
        self.layer.backgroundColor = UIColor.greenCircle.cgColor
    }
    
    func goalNumberConfiguration() {
        goalNumberView.text = String(goalValue)
        goalNumberView.font = UIFont.getRoundedFont(size: 45, weight: .bold)
        goalNumberView.textColor = .whiteCircle
        goalNumberView.translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    func goalNumberConstraints() {
        goalNumberView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -10).isActive = true
        goalNumberView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    
    }
    
    func goalTextConfiguration() {
        goalTextView.text = "goal"
        goalTextView.font = UIFont.getRoundedFont(size: 18, weight: .bold)
        goalTextView.textColor = .whiteCircle
        goalTextView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func goalTextConstraints() {
        goalTextView.topAnchor.constraint(equalTo: self.goalNumberView.bottomAnchor).isActive = true
        goalTextView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    }
    
    func setGoalValue(_ value: Int) {
        goalValue = value
        goalNumberView.text = String(goalValue)
    }
}
