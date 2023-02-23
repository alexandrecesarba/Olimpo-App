//
//  FindingBallView.swift
//  Challenge6_v1
//
//  Created by Pedro Peçanha on 14/02/23.
//

import Foundation
import UIKit

class FindingBallView: UIView {
    
    let keepSteadyTextView = UILabel()
    let instructionTextView = UILabel()
    let progressBarView = FindingProgressBar(fromFrame: .zero, usingMaximumValueAs: 60, color: .greenCircle)
    let checkmarkView = CheckmarkView(frame: .zero)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        addSubview(progressBarView)
        addSubview(keepSteadyTextView)
        addSubview(instructionTextView)
        addSubview(checkmarkView)
        progressBarConstraints()
        keepSteadyConfiguration()
        keepSteadyConstraints()
        instructionTextConfiguration()
        instructionTextConstraints()
        checkmarkConstraints()
        self.backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func checkmarkConstraints() {
        checkmarkView.trailingAnchor.constraint(equalTo: progressBarView.trailingAnchor, constant: -10).isActive = true
        checkmarkView.widthAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.08).isActive = true
        checkmarkView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.08).isActive = true
        checkmarkView.centerYAnchor.constraint(equalTo: progressBarView.centerYAnchor).isActive = true
    }
    
    func progressBarConstraints() {
        progressBarView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: progressBarView.size).isActive = true
        progressBarView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.05).isActive = true
        progressBarView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
//        progressBarView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        progressBarView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 30).isActive = true
    }
    
    func instructionTextConfiguration() {
        instructionTextView.text = "Keep you camera very still\nwhile the ball is still being detected..."
        instructionTextView.numberOfLines = 2
        instructionTextView.textAlignment = .center
        instructionTextView.font = UIFont.getRoundedFont(size: 18, weight: .regular)
        instructionTextView.textColor = .white
    }
    
    func instructionTextConstraints(){
        instructionTextView.translatesAutoresizingMaskIntoConstraints = false
        instructionTextView.topAnchor.constraint(equalTo: keepSteadyTextView.bottomAnchor, constant: 0).isActive = true
        instructionTextView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.75).isActive = true
        instructionTextView.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
//        instructionTextView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.1).isActive = true

    }
    
    func keepSteadyConfiguration() {
        keepSteadyTextView.text = "H O L D  S T E A D Y"
        keepSteadyTextView.textAlignment = .center
        keepSteadyTextView.font = UIFont.getRoundedFont(size: 24, weight: .medium)
        keepSteadyTextView.textColor = .white
//        explanatoryText.font
    }
    
    func keepSteadyConstraints(){
        keepSteadyTextView.translatesAutoresizingMaskIntoConstraints = false
        keepSteadyTextView.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
        keepSteadyTextView.topAnchor.constraint(equalTo: self.progressBarView.bottomAnchor).isActive = true
        keepSteadyTextView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.75).isActive = true
        keepSteadyTextView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.1).isActive = true
    }
}
